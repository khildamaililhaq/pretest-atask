LatestStockPrice.configure do |config|
  config.api_key = ENV["RAPID_API_KEY"]
  config.api_url = ENV["RAPID_API_URL"]
  config.api_host = ENV["RAPID_API_HOST"]
end
