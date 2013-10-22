class Credit < ActiveRecord::Base
  belongs_to :client
  belongs_to :target, polymorphic: true

  scope :by_date, -> { order("created_at") }
end
