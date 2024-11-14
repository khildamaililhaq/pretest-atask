class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :current_balance, :debits, :credits, :stock_detail
end
