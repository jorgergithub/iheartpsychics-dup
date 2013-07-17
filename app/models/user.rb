class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
end
