require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should have_many(:debits) }

  it { should have_many(:credits) }

  it { should have_one(:team_detail) }
end
