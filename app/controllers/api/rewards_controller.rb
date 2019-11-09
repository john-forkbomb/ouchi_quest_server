# frozen_string_literal: true

module Api
  class RewardsController < BaseController
    include ImageUploadable

    before_action :set_reward, only: %i[show update destroy approve]

    def index
      @rewards = current_parent.rewards
      render json: ::RewardSerializer.new(@rewards)
    end

    def show
      render json: ::RewardSerializer.new(@reward)
    end

    def create
      @reward = Reward.new(create_params)
      if @reward.save
        render json: ::RewardSerializer.new(@reward)
      else
        render_errors @reward
      end
    end

    def update
      if @reward.update(reward_params)
        render json: ::RewardSerializer.new(@reward)
      else
        render_errors @reward
      end
    end

    def destroy
      if @reward.destroy
        head :no_content
      else
        render_errors @reward
      end
    end

    def approve
      unless @reward.status.requested?
        handle_400(error_details: ['statusがrequestedではありません'])
        return
      end

      if @reward.point > @reward.child.point
        handle_400(error_details: ['ポイントが足りていません'])
        return
      end

      ActiveRecord::Base.transaction do
        ::ApproveRewardService.new.execute!(@reward)
      end

      render json: ::RewardSerializer.new(@reward)
    rescue ActiveRecord::RecordInvalid
      render_errors @reward
    end

    private

    def set_reward
      @reward = Reward.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(
        :name,
        :description,
        :point,
        :status,
        :image
      )
    end

    def create_params
      reward_params.merge(
        parent: current_parent,
        child: current_parent
      )
    end

    def former_path_pattern
      %w[uploaded images rewards]
    end
  end
end
