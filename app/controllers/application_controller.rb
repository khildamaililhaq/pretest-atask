class ApplicationController < ActionController::API
  include SerializerGenerator

  before_action :current_entity
  def current_entity
    token ||= request.headers["Authorization"] || params[:token]
    @token ||= EntityToken.active.find_by_token(token)

    if @token.present?
      @current_entity ||= @token.entity
    else
      render json: { error: "Invalid Token" }, status: :unauthorized
    end
  end
end
