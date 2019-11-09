class PushNotificationWorker
  include Sidekiq::Worker
  sidekiq_options queue: :notification

  def perform(token, payload)
    andpush.push(payload.merge(to: token))
  end

  private

  def andpush
    server_key = Rails.application.credentials.dig(:fcm, :server_key)
    Andpush.new(server_key)
  end
end
