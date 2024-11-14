class Stock < Entity
  has_one :stock_detail

  accepts_nested_attributes_for :stock_detail
end
