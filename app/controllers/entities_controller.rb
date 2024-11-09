class EntitiesController < ApplicationController
  before_action :validate_destination_entity, only: :transfer
  before_action :validate_params, only: %i[transfer deposit withdraw]
  before_action :validate_pin, only: %i[transfer deposit withdraw]

  def transfer
    data = @current_entity.transfer(transaction_params)
    render json: data, serializer: WalletTransferSerializer
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def deposit
    data = @current_entity.deposit(transaction_params)
    render json: data, serializer: WalletDepositSerializer
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def withdraw
    data = @current_entity.withdraw(transaction_params)
    render json: data
  rescue StandardError => e
    render json: { error: e }, status: :unprocessable_entity
  end

  def index
    search = Entity.where("name ILIKE ?", "%#{params[:name]}%")
    entities = search.order(name: :asc).page(params[:page]).per(params[:per_page])

    generate_collection_serializer(entities, EntitySerializer)
  end

  private

  def set_serializer
    @serializer = case @current_entity.type
    when "User"
      UserSerializer
    when "Team"
      TeamSerializer
    when "Stock"
      StockSerializer
    else
      EntitySerializer
    end
  end

  def validate_params
    render json: { error: "Invalid Params" }, status: 412 unless transaction_params[:amount].positive? && transaction_params[:amount].present?
  end

  def validate_pin
    unless @current_entity.authenticate_pin(transaction_params[:pin])
      render json: { error: "Wrong PIN or PIN not been made" }, status: :unauthorized
    end
  end

  def validate_destination_entity
    Entity.find(transaction_params[:entity_id])
  rescue StandardError
    render json: { error: "Invalid Destination Entity" }, status: 404
  end

  def transaction_params
    params.require(:wallet_transaction).permit(:entity_id, :amount, :pin)
  end
end
