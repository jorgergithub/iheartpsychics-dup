class Calls::PsychicCallbacksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    PsychicCallback.new(self)
    callback = ::Callback.find(params[:callback_id])
    response = Twilio::TwiML::Response.new do |r|
      r.Gather(action: "/calls/psychic_callback/#{callback.id}/continue") do |g|
        g.Say <<-EOS.strip_heredoc
          Hello #{callback.psychic.first_name}, this is I Heart Psychics
          calling you for a callback with #{callback.client.first_name}.

          If you are available and want to continue with the call, please
          press 1 now. Otherwise, press 2 and we'll cancel the callback.
        EOS
      end
    end

    render text: response.text
  end
end
