# frozen_string_literal: true

module Api
  class QuestsController < BaseController
    include ImageUploadable

    before_action :set_quest, only: %i[show update destroy approve]

    def index
      @quests = current_child.todays_quests
      render json: ::QuestSerializer.new(@quests)
    end

    def show
      render json: ::QuestSerializer.new(@quest)
    end

    def create
      @quest = Quest.new(create_params)

      if @quest.save
        render json: ::QuestSerializer.new(@quest)
      else
        render_errors @quest
      end
    end

    def update
      if @quest.update(quest_params)
        render json: ::QuestSerializer.new(@quest)
      else
        render_errors @quest
      end
    end

    def destroy
      if @quest.destroy
        head :no_content
      else
        render_errors @quest
      end
    end

    def approve
      unless @quest.status.finished?
        handle_400(error_details: ['statusがfinishedではありません'])
        return
      end

      ActiveRecord::Base.transaction do
        ::ApproveQuestService.new.execute!(@quest)
      end

      render json: ::QuestSerializer.new(@quest)
    rescue ActiveRecord::RecordInvalid
      render_errors @quest
    end

    private

    def set_quest
      @quest = Quest.find(params[:id])
    end

    def quest_params
      params.require(:quest).permit(
        :title,
        :description,
        :point,
        :quest_type,
        :status,
        :image
      )
    end

    def create_params
      child = Child.first
      quest_params.merge(
        child: child,
        parent: child.parent
      )
    end

    def former_path_pattern
      %w[uploaded images quests]
    end
  end
end
