class Callback < ActiveRecord::Base
  belongs_to :psychic
  belongs_to :client

  def expired?
    return false unless expires_at
    expires_at.past?
  end
end
