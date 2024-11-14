# frozen_string_literal: true

# Rest API Handler
module LatestStockPrice
  class RequestHandler
    def initialize(
      api_host: LatestStockPrice.configuration.api_host,
      api_url: LatestStockPrice.configuration.api_url,
      api_key: LatestStockPrice.configuration.api_key
    )
      @api_url = api_url
      @headers = { "X-RapidAPI-Key" => api_key, "X-RapidAPI-Host" => api_host }
    end

    def call(identifier = nil)
      @headers = @headers.merge({ params: { Identifier: identifier } })
      response = api_call("any")
      JSON.parse(response.body)
    end

    private

    def api_call(action)
      url = @api_url + action
      RestClient.get(url, @headers)
    end
  end
end
