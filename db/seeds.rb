if User.count.zero?
  10.times do
    User.create({
                     name: Faker::Name.name,
                     username: Faker::Internet.user_name,
                     password: Faker::Internet.password,
                     pin: '123456'
                   })
  end
  User.create({ name: 'Demo User', username: 'demo_user', password: 'password',  pin: '123456' })
end
