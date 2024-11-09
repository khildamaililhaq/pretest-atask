class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :current_balance, :debits, :credits, :user_detail
end
