class PsychicCallback < CallScript
  def initial_state
    callback = ::Callback.find(self.context.params[:callback_id])
    send_menu <<-EOS, { "1" => :proceed, "2" => :cancel }
      Hello #{callback.psychic.first_name}, this is I Heart Psychics
      calling you for a callback with #{callback.client.first_name}.

      If you are available and want to continue with the call, please
      press 1 now. Otherwise, press 2 and we'll cancel the callback.
    EOS
  end

  def proceed
    callback = ::Callback.find(self.context.params[:callback_id])
    send_to_conference "callback-#{callback.id}"
  end

  def cancel
    send_response <<-EOS
      Okay #{@callback.psychic.first_name}, we are now cancelling your callback.
      Thank you.
    EOS
  end
end
