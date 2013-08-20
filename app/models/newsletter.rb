class Newsletter < ActiveRecord::Base
  validates_presence_of :title, :body, :deliver_by

  def self.deliver_all
    Newsletter.where(deliver_by: Date.today).each do |n|
      n.deliver
    end
  end

  def deliver
    Client.all.each do |client|
      NewsletterMailer.send_newsletter(self, client)
    end
    update_attributes delivered: true
  end
end
