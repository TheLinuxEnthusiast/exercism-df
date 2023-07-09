from enum import Enum

class direction(Enum):
    UP=1
    DOWN=2
    LEFT=3
    RIGHT=4


def print_board(board):
    for row in board:
        tmp=""
        for n,col in enumerate(row):
            if n == len(row):
                tmp += col 
            else:
                tmp += f"{col} "
        print(tmp)


def spiral_matrix(size):
    
    val = size * size
    n=1
    current_direction = direction.RIGHT

    if size == 0:
        return []
    elif size == 1:
        return [[n]]
    else:
        board = [[0 for j in range(1, size+1)] for i in range(1, size+1)]

    x=0 # Row number
    y=0 # Column number
    while n <= val:
        board[x][y] = n
        #print(f"{n}")
        #print(f"X,Y: {x},{y}")
        #print("-----")
        #print_board(board)

        if current_direction == direction.RIGHT:
            if (y == size - 1) or (board[x][y+1] !=0):
                current_direction = direction.DOWN
                x+=1
            else:
                y+=1
        elif current_direction == direction.DOWN:
            if (x == size -1) or (board[x+1][y] !=0):
                current_direction = direction.LEFT
                y-=1
            else:
                x+=1
        elif current_direction == direction.LEFT:
            if (y == 0) or (board[x][y-1] !=0):
                current_direction = current_direction.UP
                x-=1
            else:
                y-=1
        elif current_direction == direction.UP:
            if(x == 0) or (board[x-1][y] !=0):
                current_direction = direction.RIGHT
                y+=1
            else:
                x-=1

        n+=1

    return board


if __name__ == "__main__":
    b = spiral_matrix(3)
    print("-----")
    print_board(b)