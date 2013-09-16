class Invoice < ActiveRecord::Base
  belongs_to :psychic
  belongs_to :tier
  has_many :calls

  def self.create_for(from, to)
    Psychic.all.each do |psychic|
      calls = psychic.calls.period(from, to)
      next unless calls.count > 0

      invoice = psychic.invoices.build
      invoice.process(calls)
    end
  end

  def process(calls)
    self.calls = calls
    self.number_of_calls = calls.size
    self.total_minutes = calls.sum(:duration)
    self.minutes_payout = 0
    self.bonus_minutes = 0
    self.bonus_payout = 0

    self.tier = Tier.for(self.total_minutes)

    self.calls.each do |call|
      self.minutes_payout += self.tier.payout_for(call)
      if call.bonus?
        self.bonus_minutes += call.duration
        self.bonus_payout += 0.07 * call.duration
      end
    end

    self.total = self.minutes_payout + self.bonus_payout
    self.avg_minutes = self.total_minutes.to_f / self.number_of_calls.to_f
    save
  end
end
