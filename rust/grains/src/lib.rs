pub fn square(s: u32) -> u64 {
    // formula: 2^(n-1)
    let s = match s {
        1..=64 => s,
        _ => panic!("Square must be between 1 and 64") 
    };
    return u64::pow(2, s-1);
}

pub fn total() -> u64 {
    
    let mut total = 0;
    for i in 1..=64 {
        total += square(i);
    }
    return total;
}
