class ClientNote < ActiveRecord::Base
  include I18n::Alchemy

  belongs_to :client

  validates :description, :presence => true
end
