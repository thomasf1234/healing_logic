module Strategies
  class Priority2 < ProfitCalculator
    THRESHOLD = 0.2   #the higher this is the less willing to spend magicka for little increase in Health
    MAGICKA_LEFT = 0  #healer must be left with at least this much magicka
    SPELL_TYPE = 'reanimate'

    class << self
      def definition
        'they have died'
      end
    end

    def spell_to_use(healers_spells)
      profits_spell_mapping = {}
      extract_spells_from(healers_spells).each do |spell, attributes|
        profits_spell_mapping[profit(attributes)] = spell
      end
      return profits_spell_mapping[profits_spell_mapping.keys.max] unless profits_spell_mapping.keys.max == -1
      'N/A'
    end

    def extract_spells_from spells
      spell_target = target(@healer, @patient)
      spells.select { |spell, attributes| attributes[:target] == spell_target }
    end

    def profit(spell)
      @profit = 0
      return -1 if post_heal_magicka(spell) < self.class::MAGICKA_LEFT
      @profit += health_magicka_profit(spell)
      worth_it?(@profit) ? @profit : -1
    end

    private

    def target(healer, patient)
      Spells::Target::OTHER
    end

    def worth_it? profit
      (profit > THRESHOLD) ? true : false
    end

    def health_magicka_profit(spell)
      (stat_percentage(:health, @patient, spell).gain_relative_to_base*3) + (stat_percentage(:magicka, @healer, spell).gain_relative_to_current/3)
    end
  end
end
