class User < Entity
  has_one :user_detail
  accepts_nested_attributes_for :user_detail
end
