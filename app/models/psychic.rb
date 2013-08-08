require "random_utils"

class Psychic < ActiveRecord::Base
  belongs_to :user
  delegate :username, :first_name, :last_name, :full_name, :email, to: :user

  has_and_belongs_to_many :favorited_by_clients, class_name: "Client"
  has_many :calls
  has_many :reviews

  before_create :assign_extension
  validates_uniqueness_of :extension

  mount_uploader :resume, ResumeUploader

  private

  def assign_extension
    return if self.extension
    existing_extensions = Psychic.pluck("extension")
    self.extension = RandomUtils.random_extension(existing_extensions)
  end
end
