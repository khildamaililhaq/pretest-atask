class EntitySerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :current_balance
end
