class Transaction < ActiveRecord::Base
  include I18n::Alchemy

  belongs_to :client
  belongs_to :order
end
