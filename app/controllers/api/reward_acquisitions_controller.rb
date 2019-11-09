# frozen_string_literal: true

module Api
  class RewardAcquisitionsController < BaseController
    def index
      @acquisitions = current_child.acquisitions.order(created_at: :desc)
      render json: ::RewardAcquisitionSerializer.new(@acquisitions)
    end
  end
end
