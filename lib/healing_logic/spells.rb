module Spells
  module Target
    SELF = 0
    OTHER = 1
  end

  module Schools
    RESTORATION = 'restoration'
    CONJURATION = 'conjuration'
    DESTRUCTION = 'destruction'
  end


  CONJURATION = {
      "Reanimate"              => { cost:  50, power:  0, period: 60, target: Target::OTHER  },
  }.each do |spell_id, attributes|
    attributes.merge!(school: Schools::CONJURATION)
  end


  DESTRUCTION = {
      "Flare"                  => { cost:  11, power:  6, period:  0, target: Target::OTHER  },
  }.each do |spell_id, attributes|
    attributes.merge!(school: Schools::DESTRUCTION)
  end

  HEALING = {
       "Heal Minor Wounds"      => { cost:  14, power:   8, period:  0, target: Target::SELF  },
       "Convalescence"          => { cost:  48, power:   15, period:  0, target: Target::OTHER },
       "Heal Major Wounds"      => { cost:  61, power:  25, period:  0, target: Target::SELF  },
       "Night Mother's Caress"  => { cost:  33, power:  10, period:  2, target: Target::SELF  },
       "Greater Convalescence"  => { cost: 138, power:  20, period:  2, target: Target::OTHER },
       "Heal Greater Wounds"    => { cost:  92, power:  20, period:  2, target: Target::SELF  },
       "Heal Superior Wounds"   => { cost: 246, power:  25, period:  4, target: Target::SELF  },
       "Superior Convalescence" => { cost: 277, power:  20, period:  4, target: Target::OTHER },
       "Heal Legendary Wounds"  => { cost: 466, power:  30, period:  6, target: Target::SELF  },
       "Cure Other"             => { cost:  20, power:  30, period:  0, target: Target::OTHER },
       "Cura Other"             => { cost:  90, power:  80, period:  0, target: Target::OTHER },
       "Curaga Other"           => { cost: 250, power: 140, period:  0, target: Target::OTHER },
       "Regen"                  => { cost:  60, power:  20, period: 10, target: Target::OTHER }
  }.each do |spell_id, attributes|
    attributes.merge!(school: Schools::RESTORATION)
  end

  REANIMATION = {
      "Reanimate"     => { cost:  50,  power:  0.1 },
      "Revive"        => { cost:  100, power:  0.5 },
      "Full Revive"   => { cost:  200, power:    1 },
      "Lucky Revive"  => { cost:  80,  power: 0.75 },
  }.each do |spell_id, attributes|
    attributes.merge!(school: Schools::RESTORATION)
  end

  #one spellbook, cure that teaches cure self and cure other, although only says cure

  ALL = CONJURATION.merge(HEALING).merge(DESTRUCTION)
end