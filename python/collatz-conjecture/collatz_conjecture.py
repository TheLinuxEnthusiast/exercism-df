
def steps(number):

    count=0

    if number <= 0:
        raise ValueError("Only positive integers are allowed")

    while number > 1:
        if number % 2 == 0:
            number = number / 2
        else:
            number = 3*(number) + 1
        count +=1
    
    return count

