class Hour < ActiveRecord::Base
  belongs_to :psychic

  def start?
    action == "start"
  end
end
