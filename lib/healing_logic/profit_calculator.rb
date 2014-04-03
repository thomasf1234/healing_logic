class ProfitCalculator
  class << self
    include Misc

    #is bounded by [-1,1]
    def profit(healer, patient, spell)
      stat_percentage_gain(:health, patient, spell) + stat_percentage_gain(:magicka, healer, spell)
    end

    private

    def stat_percentage_gain(stat, actor, spell)
      post_heal_stat_percentage(stat, actor, spell) - actor.stat_percentage(stat)
    end

    def post_heal_stat_percentage(stat, actor, spell)
      cap((actor.current(stat)+stat_diff_for(stat, spell)).to_f / actor.base(stat))
    end

    def stat_diff_for(stat, spell)
      case stat
        when :health
          val = net_power_for spell
          return val
        when :magicka
          val = -spell[:cost]
          return val
      end
    end

    def net_power_for spell
      if spell[:period] > 0
        spell[:power]*spell[:period]
      else
        spell[:power]
      end
    end
  end
end