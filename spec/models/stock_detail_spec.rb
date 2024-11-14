require 'rails_helper'

RSpec.describe StockDetail, type: :model do
  it { should belong_to :stock }
end
