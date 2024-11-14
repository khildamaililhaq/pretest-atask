require 'rails_helper'

RSpec.describe UserDetail, type: :model do
  it { should belong_to :user }
end
