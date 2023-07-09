
pub fn is_armstrong_number(num: u32) -> bool {
    // Number = sum of digits raised to the power of # of digits
    let number_of_digits = num.to_string().len().try_into().unwrap();
    let string_number = String::from(num.to_string());

    let mut sum_total: i64 = 0;

    for number in string_number.chars() {

        let digit = number.to_digit(10);

        match digit {
            Some(val) => sum_total += i64::pow(val as i64, number_of_digits),
            _ => return false
        };
    }

    if sum_total == num.try_into().unwrap() {
        return true;
    }
    false
}
