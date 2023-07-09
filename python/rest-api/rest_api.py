import json

class RestAPI(object):
    def __init__(self, database=None):
        self.db = Database(database)
        self.routes = {
            ('GET', '/users'): self._get_users,
            ('POST', '/add'): self._post_add,
            ('POST', '/iou'): self._post_iou,
        }
           
    def get(self, url, payload=None):
        return self._route('GET', url, payload)
        
    def post(self, url, payload=None):  
        return self._route('POST', url, payload)
    
    def _route(self, method, url, payload=None):  
        f = self.routes.get((method, url))
        if f: return f(payload)

    def _get_users(self, payload=None):  
        names = json.loads(payload).get('users', []) if payload else None

        users = self.db.query_users(names)  
        return json.dumps({'users': users})
    
    def _post_add(self, payload=None):
        if payload:
            name = json.loads(payload).get('user')
            user = self.db.add_user(name)
            return json.dumps(user)
        
    def _post_iou(self, payload=None):  
        if payload:
            obj = json.loads(payload)
            name1 = obj['lender']
            name2 = obj['borrower']
            amount = obj['amount']
            self.db.transfer(name1, name2, amount)
            users = self.db.query_users([name1, name2])
            return json.dumps({'users': users})
        

class Database:
      
    def __init__(self, data=None):      
        users = dict(self._norm(u) for u in (data or {}).get('users', []))
        self.db = {'users': users}

    def _norm(self, user):          
        obj = dict()
        obj['name'] = user['name']
        obj['owes'] = user.get('owes', {})
        obj['owed_by'] = user.get('owed_by', {})
        obj['balance'] = user.get('balance', 0.0)
        return obj['name'], obj
    
    def query_users(self, names=None):
        if names is None:
            return list(self.db['users'].values())

        else:
            return [u for n,u in self.db['users'].items() if n in names]
         
    def add_user(self, name):
        if name:
            user = self.db['users'].get(name)
    
            if not user:
                n, user = self._norm({'name': name})
          
                self.db['users'][n] = user
          
            return user
        
    def transfer(self, name1, name2, amount):
        user1 = self.db['users'][name1]
        user2 = self.db['users'][name2]
        self._update_owes(user1, user2['name'], amount)
        self._update_owes(user2, user1['name'], -amount)

    def _update_owes(self, user1, name2, amount):      
        ow = user1['owed_by'].get(name2, 0) - user1['owes'].get(name2, 0)
        bal = ow + amount
        user1['owes'].pop(name2, None)
        user1['owed_by'].pop(name2, None)

        if bal > 0:
            user1['owed_by'][name2] = bal
        elif bal < 0:
            user1['owes'][name2] = -bal

        user1['balance'] += amount


if __name__ == "__main__":
    database = {
            "users": [
                {"name": "Adam", "owes": {}, "owed_by": {}, "balance": 0.0},
                {"name": "Bob", "owes": {"Chuck": 3.0}, "owed_by": {}, "balance": -3.0},
                {"name": "Chuck", "owes": {}, "owed_by": {"Bob": 3.0}, "balance": 3.0},
            ]
        }
    api = RestAPI(database)
    payload = json.dumps({"lender": "Bob", "borrower": "Adam", "amount": 3.0})
    response = api.post("/iou", payload)
    #print(response)
    expected = {
        "users": [
            {"name": "Adam", "owes": {"Bob": 3.0}, "owed_by": {}, "balance": -3.0},
            {"name": "Bob","owes": {"Chuck": 3.0}, "owed_by": {"Adam": 3.0}, "balance": 0.0},
        ]
    }
    print(json.loads(response))