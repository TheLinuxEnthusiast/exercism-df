import sys

def rows(row_count, tri=None):
    if tri == None:
        tri=[[1]]
    if row_count < 0:
        raise ValueError("number of rows is negative")
    if row_count > sys.getrecursionlimit():
        raise RecursionError("maximum recursion depth exceeded")
    if row_count == 0:
        return []
    if row_count == 1:
        return [[1]]
    else:
        r = rows(row_count - 1, tri)
        row = [1] + [(r[-1][i] + r[-1][i + 1]) for i in range(len(r[-1]) - 1)] + [1]
        tri.append(row)
    return tri