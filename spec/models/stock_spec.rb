require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should have_many(:debits) }

  it { should have_many(:credits) }

  it { should have_one(:stock_detail) }
end
