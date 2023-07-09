pub fn collatz(n: u64) -> Option<u64> {

    let mut step_count = 0;
    let mut running_total = n;

    if n == 0 {
        return None;
    }

    loop {
        if running_total == 1 {
            break;
        }

        match running_total {
            n if n % 2 == 0 => {
                //Some(running_total = n.wrapping_div(2))
                match n.checked_div(2) {
                    Some(n) => running_total = n,
                    None => return None
                }
            },
            n if n % 2 != 0 => {
                // Some(running_total = 3*n + 1)
                //Some(running_total = n.wrapping_mul(3).wrapping_add_signed(1))
                match n.checked_mul(3) {
                    Some(n) => {
                        match n.checked_add(1) {
                            Some(n) => running_total = n,
                            None => return None
                        }
                    }
                    None => return None
                }
            },  
            _ => return Some(0)
        };
        step_count+=1;
    }
    Some(step_count)
}
