// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

use std::collections::HashMap;


pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    // Put magazine into HashMap
    // Check note vector against HashMap to check if all values are there 
    let mut magazine_words : HashMap<&str, i32> = HashMap::new();

    for word in magazine {
        let count = magazine_words.entry(word).or_insert(0);
        *count += 1;
    }

    for word in note {
        let entry = magazine_words.entry(word).or_insert(0);
        if *entry == 0 {
            return false;
        }
        *entry -= 1;
    }
    true
}
