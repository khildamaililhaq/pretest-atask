require 'rails_helper'

RSpec.describe TeamDetail, type: :model do
  it { should belong_to :team }
end
