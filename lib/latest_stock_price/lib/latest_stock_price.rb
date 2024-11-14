# frozen_string_literal: true

require_relative "latest_stock_price/version"
require_relative "latest_stock_price/configuration"
require_relative "latest_stock_price/request_handler"
require_relative "railtie" if defined?(Rails)

# Parent for All Gem Code
module LatestStockPrice
  class Error < StandardError; end
  class << self
    def price(identifier)
      @request = RequestHandler.new
      @request.call(identifier)
    end

    def prices(identifiers)
      @request = RequestHandler.new
      @request.call(identifiers)
    end

    def price_all
      @request = RequestHandler.new
      @request.call
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
