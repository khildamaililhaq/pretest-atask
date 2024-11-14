# frozen_string_literal: true

RSpec.describe LatestStockPrice do
  it "has a version number" do
    expect(LatestStockPrice::VERSION).not_to be nil
  end

  it "set configuration for intializer" do
    LatestStockPrice.configure do |config|
      config.api_key = "expected_result"
      config.api_host = "expected_result"
      config.api_url = "expected_result"
    end
    expect(LatestStockPrice.configuration.api_key).to eq("expected_result")
    expect(LatestStockPrice.configuration.api_host).to eq("expected_result")
    expect(LatestStockPrice.configuration.api_url).to eq("expected_result")
  end

  it "expect price function to return valid JSON response" do
    LatestStockPrice.configure do |config|
      config.api_key = "99d3201c84mshb970256e7b62acdp1946d5jsn460b863e2ad8"
      config.api_host = "latest-stock-price.p.rapidapi.com"
      config.api_url = "https://latest-stock-price.p.rapidapi.com/"
    end
    expect(LatestStockPrice.price("NIFTY 50")).to be_a_kind_of(Array)
    expect(LatestStockPrice.price("NIFTY 50").count).to eq(1)
  end

  it "expect prices function to return valid JSON response" do
    LatestStockPrice.configure do |config|
      config.api_key = "99d3201c84mshb970256e7b62acdp1946d5jsn460b863e2ad8"
      config.api_host = "latest-stock-price.p.rapidapi.com"
      config.api_url = "https://latest-stock-price.p.rapidapi.com/"
    end
    expect(LatestStockPrice.prices("NIFTY 50, M&MEQN")).to be_a_kind_of(Array)
    expect(LatestStockPrice.prices("NIFTY 50, M&MEQN").count).to eq(2)
  end

  it "expect price_all function to return valid JSON response" do
    LatestStockPrice.configure do |config|
      config.api_key = "99d3201c84mshb970256e7b62acdp1946d5jsn460b863e2ad8"
      config.api_host = "latest-stock-price.p.rapidapi.com"
      config.api_url = "https://latest-stock-price.p.rapidapi.com/"
    end
    expect(LatestStockPrice.price_all).to be_a_kind_of(Array)
  end
end
