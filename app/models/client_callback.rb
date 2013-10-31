class ClientCallback < CallScript
  def initial_state
    callback = ::Callback.find(self.context.params[:callback_id])
    send_menu <<-EOS, { "1" => :proceed, "2" => :cancel }
      Hello #{callback.client.first_name}, this is I Heart Psychics
      calling you for a callback with the psychic #{callback.psychic.alias_name}.

      If you are available and want to continue with the call, please
      press 1 now. Otherwise, press 2 and we'll cancel the callback.
    EOS
  end

  def proceed
    callback = ::Callback.find(self.context.params[:callback_id])
    send_to_conference "callback-#{callback.id}",
      "Please wait while we connect you with #{callback.psychic.alias_name}."
  end

  def cancel
    send_response <<-EOS
      Okay #{@callback.client.first_name}, we are now cancelling your callback.
      Thank you.
    EOS
  end
end
