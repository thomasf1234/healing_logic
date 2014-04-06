module DummyValues
  ACTOR_STATS = {
      base: { health: 600, magicka: 600 },
      current: { health: 230, magicka: 200 },
      spells: ['Heal Minor Wounds',
               "Flare",
               "Reanimate",
               "Convalescence",
               #"Greater Convalescence",
               "Cure Other",
               "Cura Other",
               "Curaga Other"],
      skills: {
          restoration: 50,
          conjuration: 50,
          destruction: 23,
      },
      priority: 3  #is pretty much fine
  }
  healer = Actor.new ACTOR_STATS
  patient_stats = ACTOR_STATS
  patient_stats[:current][:health] = 50
  patient = Actor.new patient_stats
  puts 'healer/////////////////////'
  puts ACTOR_STATS
  puts ''
  puts 'patient////////////////////'
  puts patient_stats
  puts ''
  puts 'spell//////////////////////'
  puts Strategies::Priority1.new(healer, patient).spell_to_use(healer.healing_spells)
end