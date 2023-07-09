
from functools import reduce

class Garden:

    """
    Four types of plants available; grass (G), clover (C), radishes (R), and violets (V)
    """
    def __init__(self, garden, students=None):

        if students is not None:
            students.sort()
            self.students = students
        else:
            self.students = [
            "Alice", "Bob", "Charlie", "David",
            "Eve", "Fred", "Ginny", "Harriet",
            "Ileana", "Joseph", "Kincaid", "Larry"]

        self.plant_map = {
            "V": "Violets",
            "R": "Radishes",
            "C": "Clover",
            "G": "Grass"
        }
        
        self.garden = garden.split("\n") # Stored as a 2-d array, one for each row

    def plants(self, student):

        student_index = [(n*2,n*2+1) for n,i in enumerate(self.students) if i == student]
        plants_lst = [list(i[student_index[0][0]:student_index[0][1]+1]) for i in self.garden]
        plants_lst_reduced = reduce(lambda x,y: x+y, plants_lst)
        return [self.plant_map[i] for i in plants_lst_reduced]



if __name__ == "__main__":
    garden = Garden("VVCCGG\nVVCCGG")
    print(garden.plants("Charlie"))