module Strategies
  class ProfitCalculator

    def initialize(healer, patient)
      @profit = 0
      @healer = healer
      @patient = patient
    end

    class << self
      def definition
        raise NotImplementedError.new 'not supported'
      end
    end

    def spell_to_use(healers_spells)
      raise NotImplementedError.new 'not supported'
    end

    protected

    def profit spell
      raise NotImplementedError.new 'not supported'
    end

    def worth_it? profit
      raise NotImplementedError.new 'not supported'
    end

    def health_magicka_profit
      raise NotImplementedError.new 'not supported'
    end

    def stat_percentage(stat, actor, spell)
      params = {stat: stat, actor: actor, spell: spell}
      StatPercentageCalculator.new(params)
    end
  end
end