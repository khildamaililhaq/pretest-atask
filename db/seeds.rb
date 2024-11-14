user_detail_faker = {
  email: Faker::Internet.email,
  phone_number: Faker::PhoneNumber.cell_phone,
  birthdate: Faker::Date.birthday,
  birthplace: Faker::Address.city,
  address: Faker::Address.street_address
}

team_detail_faker = {
  code: Faker::Code.ean,
  email: Faker::Internet.email
}

if User.count.zero?
  10.times do
    User.create({
                     name: Faker::Name.name,
                     username: Faker::Internet.user_name,
                     password: Faker::Internet.password,
                     pin: '123456',
                     user_detail_attributes: user_detail_faker
                   })
  end
  User.create({
                name: 'Demo User',
                username: 'demo_user',
                password: 'password',
                pin: '123456',
                user_detail_attributes: user_detail_faker })
end

if Team.count.zero?
  10.times do
    Team.create({
                  name: Faker::Name.name,
                  username: Faker::Internet.user_name,
                  password: Faker::Internet.password,
                  pin: '123456',
                  team_detail_attributes: team_detail_faker
                })
  end
  Team.create({
                name: 'Demo Team',
                username: 'demo_team',
                password: 'password',
                pin: '123456',
                team_detail_attributes: team_detail_faker })
end

GetStockPriceService.new.update_stocks
