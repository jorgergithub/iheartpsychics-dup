class Review < ActiveRecord::Base
  belongs_to :client
  belongs_to :psychic

  Ratings = {
    5 => "I'm in love",
    4 => "I have a crush",
    3 => "I'm a fan",
    2 => "I've had better",
    1 => "I want to breakup"
  }
end
