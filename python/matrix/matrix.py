class Matrix:
    def __init__(self, matrix_string: str):
        self.matrix = [i.split(" ") for i in matrix_string.split("\n")]

    def row(self, index: int) -> list[int]:
        """
        Returns row of the matrix indexed from 1
        """
        return [int(i) for i in self.matrix[index-1]]

    def column(self, index: int) -> list[int]:
        """
        Returns a column of the matrix indexed from 1
        """
        return [int(i[index-1]) for i in self.matrix]
