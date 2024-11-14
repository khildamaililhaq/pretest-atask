class EntitySerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :type
end
