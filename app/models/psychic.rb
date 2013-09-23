require "random_utils"

class Psychic < ActiveRecord::Base
  include I18n::Alchemy

  belongs_to :user

  has_many :calls
  has_many :reviews
  has_many :invoices

  has_and_belongs_to_many :favorited_by_clients, class_name: "Client"

  delegate :username, :first_name, :last_name, :full_name, :email,
           to: :user, allow_nil: true

  validates :extension, uniqueness: true
  validates :phone, presence: true
  validates :phone, as_phone_number: true

  localize :phone, :cellular_number, :emergency_contact_number, using: PhoneParser

  mount_uploader :resume, ResumeUploader

  before_create :assign_extension

  def featured_review
    reviews.featured.first
  end

  def rating
    reviews.average(:rating)
  end

  def specialties
    %w(specialties_love_and_relationships specialties_career_and_work
       specialties_money_and_finance specialties_lost_objects
       specialties_dream_interpretation specialties_pet_and_animals
       specialties_past_lives specialties_deceased).inject([]) do |arr, sp|

      arr << sp.gsub("specialties_", "").gsub("_", " ") if send(sp)
      arr

    end.join(", ")
  end

  private

  def assign_extension
    return if self.extension
    existing_extensions = Psychic.pluck("extension")
    self.extension = RandomUtils.random_extension(existing_extensions)
  end
end
