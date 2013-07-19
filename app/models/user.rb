require "phone_formatter"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_client_or_psychic
  attr_accessor :create_as
  attr_accessor :phone_number
  attr_accessor :login

  validates_uniqueness_of :username
  validates_presence_of :username

  has_one :psychic
  has_one :client

  def client?
    client.present?
  end

  def psychic?
    psychic.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      match = where(conditions).where(
        ["lower(email) = :login OR lower(username) = :login",
         { login: login.downcase }]).first

      unless match
        match = joins(client: :phones).where(conditions).where(
          ["lower(client_phones.number) = :phone",
           { phone: PhoneFormatter.parse(login) }]).first
      end

      find(match.id) if match
    else
      where(conditions).first
    end
  end

  protected

  def create_client_or_psychic
    if create_as == 'client'
      self.client = Client.create(phone_number: phone_number)
    elsif create_as == 'psychic'
      self.psychic = Psychic.create
    end
  end
end
