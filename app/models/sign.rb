class Sign
  attr_accessor :horoscope
  attr_reader :name, :first_day, :last_day

  def initialize(name, first_day, last_day)
    @horoscope, @name, @first_day, @last_day = horoscope, name, first_day, last_day
  end

  def text
    horoscope.send(name.underscore)
  end
end