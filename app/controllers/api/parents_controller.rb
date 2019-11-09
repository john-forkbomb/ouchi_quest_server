# frozen_string_literal: true

module Api
  class ParentsController < BaseController
    include ImageUploadable

    before_action :set_parent, only: %i[update]

    def update
      if @parent.update(parent_params)
        render json: ::ParentSerializer.new(@parent)
      else
        render_errors @parent
      end
    end

    def me
      render json: ::ParentSerializer.new(current_parent)
    end

    private

    def set_parent
      @parent = Parent.find(params[:id])
    end

    def parent_params
      params.require(:parent).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :image
      )
    end

    def former_path_pattern
      %w[uploaded images parents]
    end
  end
end
