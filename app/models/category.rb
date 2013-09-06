class Category < ActiveRecord::Base
  has_many :faqs, dependent: :destroy

  validates :name, :presence => true

  accepts_nested_attributes_for :faqs, allow_destroy: true, reject_if: lambda { |attributes|
    attributes[:question].blank? || attributes[:answer].blank?
  }
end
