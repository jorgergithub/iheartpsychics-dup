class PhoneFormatter
  def self.format(number)
    if number =~ /^\+(\d)(\d{3})(\d{3})(\d{4})$/
      "+#{$1}-#{$2}-#{$3}-#{$4}"
    else
      number
    end
  end
end
