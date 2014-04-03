class SpellRater
  BASE_THRESHOLD = 0.4
  class << self
    def rate(healer, subject, priority)
      ProfitCalculator.profit(healer, subject, priority) < threshold
    end

    private

    def threshold
      BASE_THRESHOLD / healer.stat_percentage(:magicka)
    end
  end
end
