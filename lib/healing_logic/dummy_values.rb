module DummyValues
  ACTOR_STATS = {
      base: { health: 300, magicka: 200 },
      current: { health: 230, magicka: 78 },
      spells: ['Heal Minor Wounds',
               "Flare",
               "Reanimate",
               "Convalescence",
               "Greater Convalescence"],
      skills: {
          restoration: 63,
          conjuration: 50,
          destruction: 23,
      },
      priority: 3  #is pretty much fine
  }
end