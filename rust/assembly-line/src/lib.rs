pub fn production_rate_per_hour(speed: u8) -> f64 {
    let speed_v: f64 = speed as f64;
    match speed {
        1..=4 => speed_v * 221.0,
        5..=8 => speed_v * 221.0* 0.9,
        9..=10 => speed_v * 221.0 * 0.77,
        0_u8 | 11_u8..=u8::MAX => 0.0
    }
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    (production_rate_per_hour(speed) / 60.0) as u32
}
