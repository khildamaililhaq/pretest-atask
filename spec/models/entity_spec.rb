require 'rails_helper'

RSpec.describe Entity, type: :model do
  subject do
    described_class.new(name: "Nama Orang",
                        username: "orang",
                        password: "akuimut")
  end

  it 'Valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Invalid with duplicate username' do
    subject.save
    new_subject = Entity.create(
      name: 'Nama Orang 2',
      username: 'orang',
      password: 'orang'
    )
    expect(new_subject).to_not be_valid
  end

  it 'Will be Authencate with correct username and password' do
    subject.save
    username = "orang"
    password = "akuimut"

    entity = Entity.find_by_username(username)

    expect(entity.authenticate(password)).to be_truthy
  end

  it 'can generate entity token' do
    subject.save
    token = subject.generate_token
    expect(token).to be_valid
  end
end
