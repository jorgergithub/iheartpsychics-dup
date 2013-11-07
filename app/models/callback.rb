class Callback < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :psychic
  belongs_to :client

  delegate :alias_name, :full_name, to: :psychic, allow_nil: true, prefix: true

  scope :active, -> { where("status = ?", "active") }
  scope :current, -> { active.where("expires_at > ?", Time.now).order("expires_at") }
  scope :next, -> { active.where("expires_at > ?", Time.now).order("created_at") }

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

  def cancel_by_psychic
    update_status "cancelled_by_psychic"
  end

  def cancel_by_client
    update_status "cancelled_by_client"
  end

  def update_status(new_status)
    update_attributes status: new_status
  end

  def execute
    psychic.call("https://ihp-fcoury.pagekite.me/#{calls_psychic_callbacks_path}?callback_id=#{self.id}")
    client.call("https://ihp-fcoury.pagekite.me/#{calls_client_callbacks_path}?callback_id=#{self.id}")
  end

  def finish(call_sid)
    call = Call.new(sid: call_sid, psychic: self.psychic, client: self.client)
    if call.completed?
      call.process
      update_status "completed"
    else
      CallbackProcessorWorker.perform_async(self.id, call_sid)
    end
  end
end
