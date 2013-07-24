class Card < ActiveRecord::Base
  belongs_to :client

  self.inheritance_column = nil
end
