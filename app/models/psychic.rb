class Psychic < ActiveRecord::Base
  belongs_to :user
  delegate :first_name, :last_name, :full_name, to: :user
  has_many :preferred_by_clients, class_name: "Client", foreign_key: "favorite_psychic_id"
end
