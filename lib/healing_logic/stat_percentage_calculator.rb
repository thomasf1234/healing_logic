class StatPercentageCalculator
  include Misc

  attr_reader :stat, :actor, :spell

  #params = {stat: :health, actor: bones, spell: {cost: 80, etc} }
  def initialize(params)
    @stat = params[:stat]
    @actor = params[:actor]
    @spell = params[:spell]
  end

  def gain_relative_to_base
    post_heal - pre_heal
  end

  # -1+0.32/0.64 = -0.50 i.e. 50% decrease from 0.64,  -1+0.64/0.32 = 1.00 i.e. 100% increase from 0.32
  def gain_relative_to_current
    -1+(post_heal / pre_heal)
  end

  def pre_heal
    @pre_heal ||= actor.current(stat).to_f / actor.base(stat)
  end

  def post_heal
    @post_heal ||= cap((actor.current(stat)+stat_diff_for(stat, spell)).to_f / actor.base(stat))
  end

  private

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