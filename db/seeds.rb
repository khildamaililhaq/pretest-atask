if Entity.count.zero?
  10.times do
    Entity.create({
                     name: Faker::Name.name,
                     username: Faker::Internet.user_name,
                     password: Faker::Internet.password
                   })
  end
  Entity.create({ name: 'Demo User', username: 'demo_user', password: 'password' })
end
