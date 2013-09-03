require "phone_formatter"

class User < ActiveRecord::Base
  include I18n::Alchemy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  before_create :build_relation

  attr_accessor :create_as
  attr_accessor :phone_number
  attr_accessor :login

  attr_accessor :package_id
  attr_accessor :card_number
  attr_accessor :card_exp_month
  attr_accessor :card_exp_year
  attr_accessor :card_cvc

  validates_uniqueness_of :username
  validates_presence_of :username

  has_one :psychic , dependent: :destroy
  has_one :client  , dependent: :destroy
  has_one :rep     , class_name: "CustomerServiceRepresentative", dependent: :destroy

  has_one :admin   , dependent: :destroy

  accepts_nested_attributes_for :psychic
  accepts_nested_attributes_for :client
  accepts_nested_attributes_for :rep
  accepts_nested_attributes_for :admin

  scope :manager_directors, -> { where("role = ?", "manager_director") }
  scope :website_admins,    -> { where("role = ?", "website_admin") }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def client?
    role == "client"
  end

  def psychic?
    role == "psychic"
  end

  def rep?
    rep.present?
  end

  def admin?
    admin.present?
  end

  def manager_director?
    role == "manager_director"
  end

  def website_admin?
    role == "website_admin"
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

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  protected

  def build_relation
    if create_as == 'client'
      self.build_client(phone_number: phone_number)
    elsif create_as == 'psychic'
      self.build_psychic
    elsif create_as == 'csr'
      self.build_rep
    elsif create_as == 'admin'
      self.build_admin
    end
    self.role = create_as
  end
end
