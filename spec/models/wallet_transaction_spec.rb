require 'rails_helper'

RSpec.describe WalletTransaction, type: :model do
  it  { should belong_to(:creditable).optional }

  it  { should belong_to(:debitable).optional }
end
