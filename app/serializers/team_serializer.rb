class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :current_balance, :debits, :credits, :team_detail
end
