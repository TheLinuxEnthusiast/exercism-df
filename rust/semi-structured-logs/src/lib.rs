// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

/// various log levels
#[derive(Clone, PartialEq, Eq, Debug)]
pub enum LogLevel {
    Info,
    Warning,
    Error,
    Debug
}
/// primary function for emitting logs
pub fn log(level: LogLevel, message: &str) -> String {
    match level {
        LogLevel::Error => error(message),
        LogLevel::Warning => warn(message),
        LogLevel::Info => info(message),
        LogLevel::Debug => debug(message)
    }
}
pub fn info(message: &str) -> String {
    let mut m = "[INFO]: ".to_owned();

    m.push_str(&message);
    m

}
pub fn warn(message: &str) -> String {
    let mut m = "[WARNING]: ".to_owned();

    m.push_str(&message);
    m
}
pub fn error(message: &str) -> String {
    let mut m = "[ERROR]: ".to_owned();

    m.push_str(&message);
    m
}
pub fn debug(message: &str) -> String {
    let mut m = "[DEBUG]: ".to_owned();

    m.push_str(&message);
    m
}
