class Sign
  attr_accessor :horoscope
  attr_reader :name, :first_day, :last_day

  BASIC_YEAR = 2014

  def initialize(name, first_day, last_day)
    @name, @first_day, @last_day = name, first_day, last_day
  end

  def self.by_date(original_date)
    year = date_before_mar_21?(original_date) ? BASIC_YEAR + 1 : BASIC_YEAR
    date = Date.new(year, original_date.month, original_date.day)

    Horoscope::SIGNS.each do |sign|
      return sign if (date >= sign.first_day && date <= sign.last_day)
    end
  end

  def text
    horoscope.send(name.underscore)
  end

  Aries       = Sign.new("Aries",       Date.new(BASIC_YEAR     ,3,21),  Date.new(BASIC_YEAR    , 4,20))
  Taurus      = Sign.new("Taurus",      Date.new(BASIC_YEAR     ,4,21),  Date.new(BASIC_YEAR    , 5,21))
  Gemini      = Sign.new("Gemini",      Date.new(BASIC_YEAR     ,5,22),  Date.new(BASIC_YEAR    , 6,21))
  Cancer      = Sign.new("Cancer",      Date.new(BASIC_YEAR     ,6,22),  Date.new(BASIC_YEAR    , 7,23))
  Leo         = Sign.new("Leo",         Date.new(BASIC_YEAR     ,7,24),  Date.new(BASIC_YEAR    , 8,23))
  Virgo       = Sign.new("Virgo",       Date.new(BASIC_YEAR     ,8,24),  Date.new(BASIC_YEAR    , 9,23))
  Libra       = Sign.new("Libra",       Date.new(BASIC_YEAR     ,9,24),  Date.new(BASIC_YEAR    , 10,23))
  Sagittarius = Sign.new("Sagittarius", Date.new(BASIC_YEAR     ,10,24), Date.new(BASIC_YEAR    , 11,22))
  Scorpio     = Sign.new("Scorpio",     Date.new(BASIC_YEAR     ,11,23), Date.new(BASIC_YEAR    , 12,21))
  Capricorn   = Sign.new("Capricorn",   Date.new(BASIC_YEAR     ,12,22), Date.new(BASIC_YEAR + 1, 1,20))
  Aquarius    = Sign.new("Aquarius",    Date.new(BASIC_YEAR + 1 ,1,21),  Date.new(BASIC_YEAR + 1, 2,19))
  Pisces      = Sign.new("Pisces",      Date.new(BASIC_YEAR + 1 ,2,20),  Date.new(BASIC_YEAR + 1, 3,20))

  private

  def self.date_before_mar_21?(date)
    (date.month < 3) || (date.month == 3 && date.day <= 20)
  end
end