class Newsletter < ActiveRecord::Base
  validates_presence_of :title, :body, :deliver_by

  scope :pending, -> { where('delivered_at IS NULL') }
  scope :available, -> { where('deliver_by <= ?', Time.now) }

  def self.deliver_pending
    Newsletter.pending.available.find_each do |newsletter|
      newsletter.deliver
    end
  end

  def deliver
    Client.subscribed.each do |client|
      NewsletterMailer.send_newsletter(self, client).deliver
    end
    update_attributes delivered_at: Time.now
  end

  def delivered?
    delivered_at.present?
  end
end
