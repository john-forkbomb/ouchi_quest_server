module Api
  class AddDeviceService
    def execute!(user, token)
      @key_name = SecureRandom.hex(8) unless user.fcm_key
      @key_name = user.fcm_key_name

      @token = token

      response = RestClient.post(url, body.to_json, header)
      key = JSON.parse(response.body)['notification_key']

      user.update!(fcm_key: key, fcm_key_name: @kay_name, device_token: token)
    end

    def url
      'https://fcm.googleapis.com/fcm/notification'
    end

    def body
      {
        operation: :create,
        notification_key_name: @key_name,
        registration_ids: [@token]
      }
    end

    def header
      {
        content_type: :json,
        accept: :json,
        project_id: Rails.application.credentials.dig(:fcm, :sender_id),
        Authorization: 'key=' + Rails.application.credentials.dig(:fcm, :api_key)
      }
    end
  end
end
