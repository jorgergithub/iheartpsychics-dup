class Callback < ActiveRecord::Base
  belongs_to :psychic
  belongs_to :client

  def expired?
    return false unless expires_at
    expires_at.past?

  def wait_for=(v)
    if v.nil?
      self.expires_at = nil
      return
    end

    self.expires_at = Time.now + v.to_i.minutes
  end

  def wait_for
    return nil if self.expires_at.nil?
    seconds = (self.expires_at - Time.now)
    seconds.to_i / 60
  end
end
