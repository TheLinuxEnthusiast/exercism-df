
#[derive(PartialEq, Debug)]
pub struct Clock {
    hours: i32,
    minutes: i32
}

impl Clock {

    pub fn new(hours: i32, minutes: i32) -> Self {
        // Minutes and hours should role over
        // negative hours
        // negative minutes
        // negative hours and negative minutes
        // Should be able to handle 24 -> 00 midnight or 25 -> 1am
        // Combine into number of minutes since 00:00
        let start = Clock { hours: 0, minutes: 0 };
        let total_min: i32 = ( hours * 60 ) + minutes;

        let mut total_hours: f32 = (total_min as f32) / 60.0;

        loop  {
            match total_hours {
                x if ( x <= 24.0 && x >= -24.0 ) => break,
                x if x < 0.0 =>  total_hours += 24.0,
                x if x > 0.0 =>  total_hours -= 24.0,
                _ => ()
            }
        }
        
        let mut final_hours: i32 = 0;
        let mut final_minutes: i32 = 0;
        if total_hours >= 0.0 {
            println!("Positive {}", total_hours);
            final_hours = final_hours + total_hours.floor() as i32;
            final_minutes = final_minutes + ( (total_hours - total_hours.floor()) * 60.0 ).round() as i32;
        }
        else {
            println!("Negative {}", total_hours);
            let final_time = 24.0 + total_hours;
            final_hours = final_hours + final_time.floor().abs() as i32;
            final_minutes = final_minutes + ( 60.0 + ((total_hours - total_hours.ceil()) * 60.0 ).round()) as i32;
        }
        
        match final_hours {
            24 => final_hours = 0,
            _ => ()
        }
        match final_minutes {
            60 => final_minutes = 0,
            _ => ()
        }

        Clock {hours: final_hours + start.hours, minutes: final_minutes + start.minutes}
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        // Add minutes
        // Minutes should roll over, min greater than 60
        // Can handle negative minutes
        let total_min: i32 = ( self.hours * 60 ) + self.minutes;
        let mut total_hours: f32 = ( total_min + minutes ) as f32/ 60.0;

        loop  {
            match total_hours {
                x if ( x <= 24.0 && x >= -24.0 ) => break,
                x if x < 0.0 =>  total_hours += 24.0,
                x if x > 0.0 =>  total_hours -= 24.0,
                _ => ()
            }
        }
        
        let mut final_hours: i32 = 0;
        let mut final_minutes: i32 = 0;
        if total_hours >= 0.0 {
            println!("Positive {}", total_hours);
            final_hours = final_hours + total_hours.floor() as i32;
            final_minutes = final_minutes + ( (total_hours - total_hours.floor()) * 60.0 ).round() as i32;
        }
        else {
            println!("Negative {}", total_hours);
            let final_time = 24.0 + total_hours;
            final_hours = final_hours + final_time.floor().abs() as i32;
            final_minutes = final_minutes + ( 60.0 + ((total_hours - total_hours.ceil()) * 60.0 ).round()) as i32;
        }
        
        match final_hours {
            24 => final_hours = 0,
            _ => ()
        }
        match final_minutes {
            60 => final_minutes = 0,
            _ => ()
        }

        Clock {hours: final_hours, minutes: final_minutes}
    }

    pub fn to_string(&self) -> String {
        format!("{}:{}",
            format!("{:0>2}", self.hours.to_string()),
            format!("{:0>2}", self.minutes.to_string())
        )
    }
}
