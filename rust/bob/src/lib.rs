use regex::Regex;

pub fn reply(message: &str) -> &str {

    let re = Regex::new("[^a-zA-Z0-9?]+").unwrap();
    let message_trimmed = re.replace_all(message, "");
    //println!("{message_trimmed}");


    if message_trimmed.trim().is_empty() {
        return "Fine. Be that way!";
    }
    else if (message_trimmed.trim().chars().last().unwrap() == '?') && (message_trimmed == message_trimmed.trim().to_uppercase()){
        if message_trimmed.trim().chars().next().unwrap().is_numeric() {
            return "Sure.";
        }
        else if message_trimmed.len() == 1 {
            return "Sure.";
        }
        else{
            return "Calm down, I know what I'm doing!";
        }
        
    }
    else if message_trimmed.trim().chars().last().unwrap() == '?' {
        return "Sure.";
    }
    else if message_trimmed.trim().chars().last().unwrap() == '?' && ! message_trimmed.trim().chars().all(|x| x.is_alphanumeric()){ 
        return "Sure.";
    }
    // else if message_trimmed == message_trimmed.trim().to_uppercase() && ! message_trimmed.trim().chars().all(|x| x.is_alphanumeric()){
    //     return "Whoa, chill out!";
    // }
    else if message_trimmed == message_trimmed.trim().to_uppercase() && message_trimmed.trim().chars().all(|x: char| x.is_alphanumeric()) {
        if message_trimmed.trim().chars().all(|x: char| x.is_numeric()) {
            return "Whatever.";
        }
        else{
            return "Whoa, chill out!";
        }
    }
    else{
        return "Whatever.";
    }
}
