use regex::Regex;

pub fn abbreviate(phrase: &str) -> String {
    if phrase == "" {
        return "".to_string();
    }

    let re_check_hyphen = Regex::new("(\\w+)-(\\w+)").unwrap();
    let re_check_camel = Regex::new("([A-Z][a-z]+)([A-Z][a-z]+)").unwrap();


    // Remove ', _ or : from string, replace with empty string ""
    let mut phrase_clone = phrase.clone()
        .to_string()
        .replace(":", "")
        .replace("'", "")
        .replace("_", "");

    // Check for hyphen word
    match re_check_hyphen.captures(&phrase_clone) {
        Some(val) => {
            let new_str = val[1].to_string() + " " + &val[2];
            phrase_clone = phrase_clone.replace(&val[0], &new_str);
        },
        None => {}
    };

    // Check for camelcase
    match re_check_camel.captures(&phrase_clone) {
        Some(val) => {
            let new_str = val[1].to_string() + " " + &val[2];
            phrase_clone = phrase_clone.replace(&val[0], &new_str);
        },
        None => {}
    };

    // Replace any open - left in string
    phrase_clone = phrase_clone.replace(" - ", " ");

    let parts = phrase_clone.split(" ");
    let collection: Vec<&str> = parts.collect();

    let mut result = String::from("");

    // Check if words match regex
    for word in collection {
        let first_letter = word.chars().next().unwrap();
        result += &first_letter.to_string();
    }

    result.to_uppercase()
}
