class ClientCallbackWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(callback_id)
    callback = Callback.find(callback_id)
    return unless callback

    Rails.logger.info "[ClientCallbackWorker] Calling client #{callback.client_full_name}"
    callback.call_client
  end
end
