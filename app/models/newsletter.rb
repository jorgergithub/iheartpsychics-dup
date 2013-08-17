class Newsletter < ActiveRecord::Base
  validates_presence_of :title, :body, :deliver_by
end
