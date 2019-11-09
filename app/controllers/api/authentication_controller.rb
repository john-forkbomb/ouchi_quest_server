# frozen_string_literal: true

module Api
  class AuthenticationController < ApplicationController
    protect_from_forgery except: %i[login]

    def register
      ActiveRecord::Base.transaction do
        @parent = Parent.create!(parent_params)
        @child = @parent.build_child(child_params).save!
      end

      render json: auth_response
    rescue ActiveRecord::RecordInvalid
      render_errors @parent
    end

    def login
      @parent = Parent.find_for_database_authentication(email: params[:email])

      if @parent.valid_password?(params[:password])
        render json: auth_response
      else
        render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
      end
    end

    def logout
      render json: { errors: ['Not implemented yet!!'] }
    end

    def add_device
      # TODO: Add error response
      return unless params[:token]

      if params[:is_parent]
        AddDeviceService.new.execute!(current_parent, params[:token])
        render json: ::ParentSerializer.new(current_parent)
      else
        AddDeviceService.new.execute!(current_child, params[:token])
        render json: ::ChildSerializer.new(current_child)
      end
    end

    private

    # dark code.
    def parent_params
      params.require(:parent).permit(
        :name,
        :email
      ).merge(
        password: params[:password],
        password_confirmation: params[:password]
      )
    end

    def child_params
      params.require(:child).permit(
        :name,
        :sex
      )
    end

    def auth_response
      {
        token: JsonWebToken.encode({ parent_id: @parent&.id, exp: (Time.now + 2.week).to_i }),
      }
    end
  end
end
