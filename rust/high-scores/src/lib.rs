
#[derive(Debug)]
pub struct HighScores<'a> {
    scores_list: &'a [u32]
}

impl<'a> HighScores<'a> {
    pub fn new(scores: &'a [u32]) -> Self {
        //unimplemented!("Construct a HighScores struct, given the scores: {scores:?}")
        HighScores {
            scores_list: scores
        }
    }

    pub fn scores(&self) -> &[u32] {
        //unimplemented!("Return all the scores as a slice")
        self.scores_list
    }

    pub fn latest(&self) -> Option<u32> {
        //unimplemented!("Return the latest (last) score")
        match self.scores_list.len() {
            0 => None,
            n => Some(self.scores_list[n-1])
        }
    }

    pub fn personal_best(&self) -> Option<u32> {
        //unimplemented!("Return the highest score")
        let mut large = self.scores_list.get(0)?;
        for number in self.scores_list {
            if large < number {
                large = number
            }
        }
        
        Some(*large)
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        //unimplemented!("Return 3 highest scores")
        let mut v: Vec<u32> = Vec::new();
        for number in self.scores_list {
            v.push(*number);
        }
        v.sort();
        v.reverse();
        let vec_len = v.len();

        if vec_len < 3{
            v[0..vec_len].to_vec()
        }else{
            v[0..=2].to_vec()
        }
        //println!("{vec_len}");
    }
}
