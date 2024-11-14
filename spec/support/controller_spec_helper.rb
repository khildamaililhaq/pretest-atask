module ControllerSpecHelper
  def generate_token
    Entity.create(name: 'Valid', username: 'valid', password: 'valid', pin: '123456')
    Entity.last.generate_token.token
  end

  def generate_user_token
    user = User.create(name: 'Valid User', username: 'validuser', password: 'validuser', pin: '123456')
    user.deposit({ amount: 10_000 })
    user.generate_token.token
  end

  def generate_team_token
    team = Team.create(name: 'Valid Team', username: 'validteam', password: 'validteam', pin: '123456')
    team.deposit({ amount: 10_000 })
    team.generate_token.token
  end

  def generate_stock_token
    stock = Stock.create(name: 'Valid Stock', username: 'validstock', password: 'validstock', pin: '123456')
    stock.deposit({ amount: 100_000 })
    stock.generate_token.token
  end

  def generate_user
    User.create(name: 'Valid User2', username: 'validuser2', password: 'validuser', pin: '123456')
  end

  def generate_team
    Team.create(name: 'Valid Team2', username: 'validteam2', password: 'validteam2', pin: '123456')
  end

  def generate_stock
    Stock.create(name: 'Valid Stock2', username: 'validstock2', password: 'validstock2', pin: '123456')
  end

  # return valid headers
  def valid_headers
    {
      "Authorization" => generate_token
      # "Content-Type" => "application/json"
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Authorization" => nil
      # "Content-Type" => "application/json"
    }
  end
end
