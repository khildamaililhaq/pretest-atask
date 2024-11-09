module Api
  class TeamsController < EntitiesController
    before_action :set_serializer, only: :show
    before_action :check_permission

    def show
      render json: @current_entity, serializer: @serializer
    end

    private

    def check_permission
      render json: { error: "Unauthorized" }, status: :unauthorized unless @current_entity.type == "Team"
    end
  end
end
