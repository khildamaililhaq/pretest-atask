# frozen_string_literal: true

# lib/railtie.rb
require "latest_stock_price"
require "rails"

module LatestStockPrice
  class Railtie < Rails::Railtie
    railtie_name :latest_stock_price

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/*.rake").each { |f| load f }
    end
  end
end
