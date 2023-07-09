/// Create an empty vector
pub fn create_empty() -> Vec<u8> {
    vec![]
}

/// Create a buffer of `count` zeroes.
///
/// Applications often use buffers when serializing data to send over the network.
pub fn create_buffer(count: usize) -> Vec<u8> {

        let mut v : Vec<u8> = Vec::new();
        let mut val: u8 = 0;

        loop {
            if val == (count as u8) {
                break;
            }
            v.push(0);
            val += 1;
        }
        v
}

/// Create a vector containing the first five elements of the Fibonacci sequence.
///
/// Fibonacci's sequence is the list of numbers where the next number is a sum of the previous two.
/// Its first five elements are `1, 1, 2, 3, 5`.
#[allow(unused)]
pub fn fibonacci() -> Vec<u8> {
    let mut n = 0;
    let mut current = 1;
    let mut previous = 0;
    let mut nth = 1;
    let mut v: Vec<u8> = Vec::new();

    while n < 5 {
        v.push(current);
        nth = current + previous;
        previous = current;
        current = nth;
        n+=1;
    }
    v
}
