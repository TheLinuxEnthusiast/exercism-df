pub fn series(digits: &str, len: usize) -> Vec<String> {
    //unimplemented!("What are the series of length {len} in string {digits:?}")

    match len {
        0 => return vec!["".to_string(); digits.len()+1],
        l if l > digits.len() => return vec![],
        l if l == digits.len() => return vec![digits.to_string()],
        l if l < digits.len() => {
            
            let digits_string = digits.to_string();
            let mut curr_idx = 0;
            let mut result: Vec<String> = vec![];
            
            while (curr_idx + len-1) < digits.len() {
                result.push(digits_string[curr_idx..=len+curr_idx-1].to_string());
                curr_idx+=1;
            }
            return result
        }
        _ => { return vec![] }
    }


}
