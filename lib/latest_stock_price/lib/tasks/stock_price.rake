# frozen_string_literal: true

require "rake"
desc "Task to update stock prices"

namespace :stock_price do
  desc "get stock prices"
  task :get_price, [:identifier] => [:environment] do |_t, args|
    p LatestStockPrice.price(args[:identifier])
  end

  task get_prices: [:environment] do |_t, args|
    identifiers = ""
    args.extras.each do |params|
      identifiers += if identifiers.present?
                       ",#{params}"
                     else
                       params
                     end
    end
    LatestStockPrice.prices(identifiers).each do |stock|
      p stock
    end
  end

  desc "Get all stock prices"
  task get_all: :environment do
    LatestStockPrice.price_all.each do |stock|
      p "#{stock["identifier"]} | #{stock["lastPrice"]}"
    end
  end
end
