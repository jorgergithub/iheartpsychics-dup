class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_client_or_psychic
  attr_accessor :create_as

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

  protected

  def create_client_or_psychic
    if create_as == 'client'
      self.client = Client.create
    end
  end
end
