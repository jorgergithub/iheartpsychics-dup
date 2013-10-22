module DateTimeHelper
  def parse_only_time(date)
    if date.is_a?(String)
      date = Time.parse(date)
    end

    I18n.l date, format: "%I:%M %p"
  end

  def parse_only_date(date)
    if date.is_a?(String)
      date = Time.parse(date)
    end

    I18n.l date, format: "%b %d, %Y"
  end
end
