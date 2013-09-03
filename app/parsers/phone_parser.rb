module PhoneParser
  extend self

  def parse(value)
    valid_for_parsing?(value) ? remove_dashes(value) : value
  end

  def localize(value)
    if value =~ /^\+(\d)(\d{3})(\d{3})(\d{4})$/
      "+#{$1}-#{$2}-#{$3}-#{$4}"
    else
      value
    end
  end

  protected

  def remove_dashes(value)
    value.gsub("-", "")
  end

  def valid_for_parsing?(value)
    value =~ /\+1-\d{3}-\d{3}-\d{4}/
  end
end
