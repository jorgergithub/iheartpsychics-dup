class Psychic < ActiveRecord::Base
  belongs_to :user
  delegate :first_name, :last_name, to: :user
end
