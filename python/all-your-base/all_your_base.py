def rebase(input_base: int, digits: list[int], output_base: int) -> list[int]:
    """
    Description: Converts from one base number system to another
    param:
    - input_base: input base system as an int
    - digits: list of digits to be converted
    - output base: output base system as an int
    """
    
    def convert_to_base_10(input_base: int, digits: list[int]) -> int:
        power = len(digits)-1
        total_10 = 0
        for i in digits:
            total_10 += i*(input_base**power)
            power -= 1
        
        return total_10

    def convert_to_base_n(output_base: int, input_digit: int) -> list[int]:
        result = []
        quotient = input_digit
        
        while True:
            if quotient == 0:
                break
            tmp = int(quotient / output_base)
            remainder = quotient % output_base
            result.append(remainder)
            quotient = tmp

        return result[::-1]


    if input_base < 2:
        raise ValueError("input base must be >= 2")
    
    if output_base < 2:
        raise ValueError("output base must be >= 2")
    
    if not digits: # If the list if empty
        return [0]
    
    if (digits.count(digits[0]) == len(digits)) and digits[0] == 0:
        return [0]
    
    for d in digits:
        if d >= 0 and d < input_base:
            continue
        else:
            raise ValueError("all digits must satisfy 0 <= d < input base")
        
    # Convert to base 10
    input_as_base10 = convert_to_base_10(input_base, digits)

    return convert_to_base_n(output_base, input_as_base10)
        
    
        
    
    
    

