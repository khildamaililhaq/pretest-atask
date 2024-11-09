require 'rails_helper'

RSpec.describe Entity, type: :model do
  subject do
    described_class.new(name: "Nama Orang",
                        username: "orang",
                        password: "akuimut",
                        pin: "123456")
  end

  let(:entity1) { Entity.new(
    name: Faker::Name.name,
    username: 'orang1',
    password: 'akuimut',
    pin: '123456'
  )}

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

  it 'Will be Authenticate with correct username and password' do
    subject.save
    password = "akuimut"

    expect(subject.authenticate(password)).to be_truthy
  end

  it 'can generate entity token' do
    subject.save
    token = subject.generate_token
    expect(token).to be_valid
  end

  it 'can deposit money' do
    subject.save
    subject.deposit({ amount: 10 })
    expect(subject.current_balance).to eq(10)
  end

  it 'can transfer money' do
    subject.save
    entity1.save
    entity1.deposit({ amount: 10 })
    entity1.transfer({ amount: 5, entity_id: subject.id })
    expect(subject.current_balance).to eq(5)
    expect(entity1.current_balance).to eq(5)
  end

  it "can't transfer money when balance not enough" do
    subject.save
    entity1.save
    entity1.deposit({ amount: 10 })
    expect { entity1.transfer({ amount: 15, entity_id: subject.id }) }
      .to raise_error(StandardError)
  end

  it 'can withdraw money' do
    subject.save
    subject.deposit({ amount: 10 })
    expect(subject.withdraw({ amount: 5 })).to be_valid
  end

  it "can't withdraw money if balance not enough" do
    entity1.save
    entity1.deposit({ amount: 5 })
    expect { entity1.withdraw({ amount: 15 }) }
      .to raise_error(StandardError)
  end
end
