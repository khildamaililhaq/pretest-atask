module ControllerSpecHelper
  def generate_token
    Entity.create(name: 'Valid', username: 'valid', password: 'valid')
    Entity.last.generate_token.token
  end

  def generate_user_token
    user = User.create(name: 'Valid User', username: 'validuser', password: 'validuser')
    user.deposit({ amount: 10_000 })
    user.generate_token.token
  end

  def generate_team_token
    team = Team.create(name: 'Valid Team', username: 'validteam', password: 'validteam')
    team.deposit({ amount: 10_000 })
    team.generate_token.token
  end

  def generate_stock_token
    stock = Stock.create(name: 'Valid Stock', username: 'validstock', password: 'validstock')
    stock.deposit({ amount: 10_000 })
    stock.generate_token.token
  end

  def generate_user
    User.create(name: 'Valid User2', username: 'validuser2', password: 'validuser')
  end

  def generate_team
    Team.create(name: 'Valid Team2', username: 'validteam2', password: 'validteam2')
  end

  def generate_stock
    Stock.create(name: 'Valid Stock2', username: 'validstock2', password: 'validstock2')
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
