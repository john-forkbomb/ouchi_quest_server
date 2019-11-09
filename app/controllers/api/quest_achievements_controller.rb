# frozen_string_literal: true

module Api
  class QuestAchievementsController < BaseController
    def index
      @achievements = current_child.achievements.order(created_at: :desc)
      render json: ::QuestAchievementSerializer.new(@achievements)
    end
  end
end
