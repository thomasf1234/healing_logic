class Actor
  attr_accessor :spells, :skills

  def initialize params
    @base_stats = { health: params[:base][:health], magicka: params[:base][:magicka] }
    @current_stats = { health: params[:current][:health], magicka: params[:current][:magicka] }
    @skills = params[:skills]
    @spells = get_data_for params[:spells]
    @priority =  params[:priority]
  end

  def stat_percentage stat
    current(stat).to_f / base(stat)
  end

  def healer?
    healing_spells.empty? ? false : true
  end

  def current stat
    @current_stats[stat]
  end

  def base stat
    @base_stats[stat]
  end

  def healing_spells
    spells.select { |spell, attributes| attributes[:school] == Spells::Schools::RESTORATION }
  end

  private

  def get_data_for spells
    binding.pry
    hash = {}
    spells.each do |spell|
      hash[spell] = Spells::ALL[spell]
      hash[spell][:cost] =  recalculate_cost_for hash[spell]
    end
    spells = hash
  end

  def recalculate_cost_for spell
    spell[:cost] * (1.4 - ( 0.012 * skills[spell[:school].to_sym] ))
  end
end