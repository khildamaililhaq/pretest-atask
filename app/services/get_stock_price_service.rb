class GetStockPriceService
  def initialize
  end

  def update_stocks
    data = LatestStockPrice.price_all
    data.map do |stock|
      current_stock = Stock.find_by(username: stock["symbol"])
      if current_stock.present?
        update_stock(current_stock, stock)
      else
        insert_stock(stock)
      end
    end
  end

  private

  def update_stock(current_stock, updated_stock)
    status = current_stock.stock_detail
    status.update(detail_hash(updated_stock))
    puts "Stock #{current_stock.name} updated: #{status.update(detail_hash(updated_stock))}"
  end

  def detail_hash(stock)
    {
      symbol: stock["symbol"],
      identifier: stock["identifier"],
      open: stock["open"],
      day_high: stock["dayHigh"],
      day_low: stock["dayLow"],
      last_price: stock["lastPrice"],
      previous_close: stock["previousClose"],
      change: stock["change"],
      p_change: stock["pChange"],
      year_high: stock["yearHigh"],
      year_low: stock["yearLow"],
      total_traded_volume: stock["totalTradedVolume"],
      total_traded_value: stock["totalTradedValue"],
      last_updated_time: stock["lastUpdateTime"],
      per_change_365d: stock["perChange365d"],
      per_change_30d: stock["perChange30d"]
    }
  end

  def insert_stock(stock)
    item = Stock.new({
                       name: stock["identifier"],
                       username: stock["symbol"],
                       password: stock["symbol"],
                       pin: "123456",
                       stock_detail_attributes: detail_hash(stock)
                     })
    item.save
    puts "Stock #{item.name} created: #{item.errors.messages}"
  end

  def remove(string)
    string.gsub!(/ /, "") if string.include? " "
  end
end
