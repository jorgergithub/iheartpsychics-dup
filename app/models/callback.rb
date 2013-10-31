class Callback < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :psychic
  belongs_to :client

  delegate :alias_name, :full_name, to: :psychic, allow_nil: true, prefix: true

  scope :current, -> { where("expires_at > ?", Time.now).order("expires_at") }
  scope :next, -> { where("expires_at > ?", Time.now).order("created_at") }

  def expired?
    return false unless expires_at
    !expires_at.future?
  end

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

  def execute
    psychic.call("http://r.fcoury.com:6674/#{calls_psychic_callbacks_path}?callback_id=#{self.id}")
  end
end
