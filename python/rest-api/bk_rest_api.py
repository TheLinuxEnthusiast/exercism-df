import json

class RestAPI:
    def __init__(self, database=None):
        """
        Database Fields: 
        - name
        - owes
        - owed_by
        - balance

        {
            "users": [
                {"name": "Adam", "owes": {}, "owed_by": {}, "balance": 0.0},
                {"name": "Bob", "owes": {}, "owed_by": {}, "balance": 0.0},
            ]
        }
        """
        self.database = database

    def get(self, url, payload=None):
        """
        {"users": ["Bob"]}
        """

        if payload is None:
            users_lst = []
        else:
            payload_dict = json.loads(payload)

            if url == "/users":
                users_lst = [i for i in self.database["users"] if i["name"] == payload_dict["users"][0]]
        
        return json.dumps({
            "users": users_lst
        })

    def post(self, url, payload=None):
        """
        /add will add a new user into the database
        /iou will add an iou to the database
        """
        payload_dict = json.loads(payload)

        if url == "/add":
            """
            {"user": "Adam"}
            """
            self.database["users"] += { "name": payload_dict["user"], 
                                        "owes": {}, 
                                        "owed_by": {}, 
                                        "balance": 0.0
                                        }
            
            return json.dumps({ "name": payload_dict["user"], 
                                        "owes": {}, 
                                        "owed_by": {}, 
                                        "balance": 0.0
                                        })
                
        elif url == "/iou":
            """
            Example payload
            {"lender": "Adam", "borrower": "Bob", "amount": 3.0}
            """
            users_names = [payload_dict["lender"], payload_dict["borrower"]]

            for user in self.database["users"]:
                if user["name"] == payload_dict["lender"]:
                    borrow = { 
                        payload_dict["borrower"]: payload_dict["amount"]
                        }
                    user["owed_by"] = {**user["owed_by"], **borrow}
                elif user["name"] == payload_dict["borrower"]:
                    lender = {
                        payload_dict["lender"]: payload_dict["amount"]
                    }
                    user["owes"] = {**user["owes"], **lender}
            
            # Resolve balance
            # Sum of owes - sum of owed_by
            
            for user in self.database["users"]:
                sum_of_owes = 0
                sum_of_owed_by = 0
                #name = user["name"]

                for owe in user["owes"].items():
                    sum_of_owes += owe[1]
                
                for owed in user["owed_by"].items():
                    sum_of_owed_by += owed[1]

                user["balance"] = sum_of_owed_by - sum_of_owes
            
            # If users in owed and owes are the same re-balance
            for user in self.database["users"]:
                #user["owed_by"].item()
                #user["owes"].items()
                res = {key: user["owes"][key] - user["owed_by"].get(key, 0) for key in user["owes"].keys()}
                res2 = {key: user["owed_by"][key] - user["owes"].get(key, 0) for key in user["owed_by"].keys()}
                res_total = {**res2, **res}
                #print(res)
                #print(res_total)
                if not res_total:
                    user["owed_by"] = {}
                    user["owes"] = {}
                else:
                    for name in res_total.items():
                        if user["balance"] < 0:
                            tmp = {f"{name[0]}": abs(name[1])}
                            user["owes"] = {**user["owes"], **tmp}
                            user["owed_by"] = {}
                        if user["balance"] >= 0:
                            tmp = {f"{name[0]}": abs(name[1])}
                            user["owed_by"] = {**user["owed_by"], **tmp}
                            user["owes"] = {}


            return json.dumps({
                "users": [i for i in self.database["users"] if i["name"] in users_names]
            })

        else:
            pass


if __name__== "__main__":
    #rest_api_test.py::RestApiTest::test_lender_has_negative_balance
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
    print(response)
    expected = {
        "users": [
            {"name": "Adam", "owes": {"Bob": 3.0}, "owed_by": {}, "balance": -3.0},
            {
                "name": "Bob",
                "owes": {"Chuck": 3.0},
                "owed_by": {"Adam": 3.0},
                "balance": 0.0,
            },
        ]
    }
