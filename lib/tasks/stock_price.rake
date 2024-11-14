# frozen_string_literal: true

require "rake"
desc "Task to update stock prices"

namespace :stock_price do
  desc "Get all stock prices"
  task update_all: :environment do
    GetStockPriceService.new.update_stocks
  end
end
