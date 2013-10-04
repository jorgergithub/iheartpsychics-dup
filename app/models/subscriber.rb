class Subscriber < ActiveRecord::Base
  validates_presence_of :email
  validates_uniqueness_of :email, message: "already subscribed"
end