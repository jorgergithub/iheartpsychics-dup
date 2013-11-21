class Sign
  attr_accessor :horoscope
  attr_reader :name, :first_day, :last_day

  def initialize(name, first_day, last_day)
    @name, @first_day, @last_day = name, first_day, last_day
  end

  def text
    horoscope.send(name.underscore)
  end

  Aries       = Sign.new("Aries",       Date.new(2014,3,21), Date.new(2014,4,19))
  Taurus      = Sign.new("Taurus",      Date.new(2014,4,20), Date.new(2014,5,20))
  Gemini      = Sign.new("Gemini",      Date.new(2014,5,21), Date.new(2014,6,21))
  Cancer      = Sign.new("Cancer",      Date.new(2014,6,22), Date.new(2014,7,22))
  Leo         = Sign.new("Leo",         Date.new(2014,7,23), Date.new(2014,8,22))
  Virgo       = Sign.new("Virgo",       Date.new(2014,3,21), Date.new(2014,4,21))
  Libra       = Sign.new("Libra",       Date.new(2014,4,20), Date.new(2014,5,20))
  Sagittarius = Sign.new("Sagittarius", Date.new(2014,4,20), Date.new(2014,5,20))
  Scorpio     = Sign.new("Scorpio",     Date.new(2014,4,20), Date.new(2014,5,20))
  Capricorn   = Sign.new("Capricorn",   Date.new(2014,4,20), Date.new(2014,5,20))
  Aquarius    = Sign.new("Aquarius",    Date.new(2014,4,20), Date.new(2014,5,20))
  Pisces      = Sign.new("Pisces",      Date.new(2014,4,20), Date.new(2014,5,20))
end