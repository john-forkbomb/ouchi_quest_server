# frozen_string_literal: true

module Api
  class BaseController < ::ApplicationController
    protect_from_forgery

    include ErrorRescuable

    before_action :authenticate_request!

    attr_reader :current_parent
    attr_reader :current_child

    def render_errors(obj)
      handle_400 error_details: obj.errors.full_messages
    end

    private

    def authenticate_request!
      unless user_id_in_token?
        handle_403(error_details: ['ログインしてください'])
        return
      end
      @current_parent = Parent.find(auth_token[:parent_id])
      @current_child = @current_parent.child
    rescue JWT::VerificationError, JWT::DecodeError
      handle_403(error_details: ['ログインしてください'])
    end

    def http_token
      @http_token ||= if request.headers['Authorization'].present?
                        request.headers['Authorization'].split(' ').last
                      end
    end

    def auth_token
      @auth_token ||= JsonWebToken.decode(http_token)
    end

    def user_id_in_token?
      http_token && auth_token && auth_token[:parent_id].to_i
    end
  end
end
