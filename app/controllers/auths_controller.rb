class AuthsController < ApplicationController
  skip_before_action :current_entity, only: :login
  before_action :set_entity, only: :login
  def login
    if @entity.authenticate(params[:password])
      render json: @entity.generate_token
    else
      render json: {
        error: "Invalid Password"
      }, status: :unauthorized
    end
  end

  def me
    render json: @current_entity
  end

  def logout
    render json: @token.destroy
  end

  private

  def set_entity
    @entity = Entity.find_by(username: params[:username])

    render json: { error: "Invalid Username" }, status: :unauthorized unless @entity.present?
  end
end
