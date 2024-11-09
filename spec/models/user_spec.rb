require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:debits) }

  it { should have_many(:credits) }

  it { should have_one(:user_detail) }
end
