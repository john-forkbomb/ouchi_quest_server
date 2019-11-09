# frozen_string_literal: true

module Api
  class PointGrantsController < BaseController
    def index
      @grants = current_child.grants.order(created_at: :desc)
      render json: ::PointGrantSerializer.new(@grants)
    end
  end
end
