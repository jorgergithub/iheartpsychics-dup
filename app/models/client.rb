require "random_utils"

class Client < ActiveRecord::Base
  belongs_to :user

  has_many :calls
  has_many :phones, class_name: "ClientPhone", dependent: :destroy
  has_many :credits, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :orders
  has_many :transactions
  has_many :reviews
  has_many :call_surveys, through: :calls

  has_and_belongs_to_many :favorite_psychics, class_name: "Psychic"

  delegate :username, :first_name, :last_name, :full_name, :email,
           to: :user, allow_nil: true

  after_create :add_phone_number
  before_save  :set_random_pin
  before_save  :set_unsubscribe_key

  scope :subscribed, -> { where('receive_newsletters') }

  attr_accessor :phone_number

  def valid_pin?(pin)
    self.pin == pin
  end

  def balance?
    balance.present? and balance != 0
  end

  def pin?
    pin.present?
  end

  def discount_credits(call)
    credits.create(
      credits: -call.cost,
      description: "Call with #{call.psychic.full_name}", target: call)
    self.balance ||= 0
    self.balance -= call.cost
    self.save
  end

  def add_credits(m, target=nil)
    desc = "Added credits"
    desc = "#{desc} - #{target.to_desc}" if target
    credits.create(credits: m, description: desc, target: target)
    self.balance ||= 0
    self.balance += m.to_f
    self.save
  end

  def seconds
    balance * 60
  end

  def psychics
    unique_ids = [favorite_psychic_ids, calls.pluck("DISTINCT psychic_id")].flatten.uniq
    Psychic.where("id IN (?)", unique_ids)
  end

  def favorite?(psychic)
    favorite_psychic_ids.include? psychic.id
  end

  def stripe_client(reload=false)
    @stripe_client = nil if reload

    if stripe_client_id
      return @stripe_client ||= Stripe::Customer.retrieve(stripe_client_id)
    end

    @stripe_client ||= begin
      desc = "#{id} - #{full_name} (#{username})"
      Stripe::Customer.create(description: desc).tap do |sc|
        update_attributes stripe_client_id: sc.id
      end
    end
  end

  def charge(amount, description, extras={})
    transaction = transactions.create(extras.merge(operation: "charge"))
    client = stripe_client
    amount_int = (amount * 100).to_i
    result = Stripe::Charge.create(customer: client.id, amount: amount_int,
                                   currency: "usd", description: description)
    card = cards.first.to_s
    transaction.update_attributes success: true, transaction_id: result.id,
                                  amount: amount, card: card
    result
  end

  def add_card_from_token(token)
    # stripe_client.cards.create(card: token)
    stripe_client.card = token
    stripe_client.save
    save_cards
  end

  def save_cards
    cards.destroy_all
    stripe_client(true).cards.each do |card|
      attributes = card.to_hash.dup
      attributes[:stripe_id] = attributes.delete(:id)
      attributes = attributes.slice(*Card.columns.map(&:name).map(&:to_sym))

      cards.create(attributes)
    end
  end

  def card
    cards.take
  end

  def set_random_pin
    return if self.pin

    RandomUtils.digits_s(4).tap do |p|
      self.pin = p
      self.save
    end
  end

  def reset_pin(pin)
    self.pin = pin
    self.save
    ClientMailer.delay.reset_pin_email(self)
  end

  def unsubscribe_from_newsletters
    update_attributes receive_newsletters: false
  end

  private

  def set_unsubscribe_key
    return if self.unsubscribe_key
    self.unsubscribe_key = RandomUtils.alpha_s(20)
  end

  def add_phone_number
    return unless self.phone_number

    phone = self.phones.build.tap do |object|
      object.localized.assign_attributes(number: self.phone_number, desc: "Main")
    end

    phone.save
  end
end
