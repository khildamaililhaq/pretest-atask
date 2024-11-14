class Team < Entity
  has_one :team_detail
  accepts_nested_attributes_for :team_detail
end
