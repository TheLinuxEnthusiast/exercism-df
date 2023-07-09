pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    
    let mut multiples: Vec<u32> = vec![];

    for item in factors {
        
        if *item == 0 {
            continue;
        }

        let mut tmp = item.clone();
        
        while tmp < limit {
            if ! multiples.contains(&tmp) {
                multiples.push(tmp);
            }
            tmp += *item;
        }
    }
    multiples.iter().map(|&i| i as u32).sum()
}
