pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {
    pub fn revive(&self) -> Option<Player> {
        if self.health == 0 && self.level >= 10 {
            Some(Player {health: 100, mana: Some(100), level:  self.level })
        }
        else if self.health == 0 && self.level < 10 {
            Some(Player {health: 100, mana: None, level:  self.level })
        }
        else {
            None
        }
    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {
        if self.mana == None {
            if mana_cost > self.health {
                self.health = 0;
                return 0;
            }
            else {
                self.health -= mana_cost;
                return 0;
            }  
        }
        else if self.mana < Some(mana_cost) {
            return 0;
        }
        else {
            let val: u32 = self.mana.unwrap();
            self.mana = Some(val - mana_cost); 
            return mana_cost * 2;
        }
    }
}
