require 'rails_helper'

RSpec.describe EntityToken, type: :model do
  it { should belong_to(:entity).without_validating_presence }

  it 'Only show active token' do
    entity = Entity.create(name: 'Orang', username: 'orang', password: 'akuimut')
    first_token = entity.generate_token
    second_token = entity.generate_token
    second_token.update(expired_at: 1.day.ago)

    expect(EntityToken.active).to include(first_token)
  end
end
