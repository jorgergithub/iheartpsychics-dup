class CallbacksController < ApplicationController
  protect_from_forgery :except => :create

  def create
    response = Twilio::TwiML::Response.new do |r|
      r.Say <<-EOS
        Hello Felipe, this is your callback from I Heart Psychics, please
        wait while we connect you to Peter
      EOS
      r.Dial "+17863295532"
    end

    render text: response.text
  end
end
