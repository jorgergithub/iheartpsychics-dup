class ClientPhone < ActiveRecord::Base
  belongs_to :client

  def formatted_number
    if number =~ /^\+(\d)(\d{3})(\d{3})(\d{4})$/
      "+#{$1}-#{$2}-#{$3}-#{$4}"
    end
  end
end
