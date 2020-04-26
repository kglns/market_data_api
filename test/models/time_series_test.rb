require 'test_helper'

class TimeSeriesTest < ActiveSupport::TestCase
  test "should not create StockPrice without symbol" do
    stock_price = StockPrice.new
    assert_not stock_price.save
  end

  test "should not create TimeSeries without symbol" do
    time_series = TimeSeries.new(low: 1.2314)
    assert_not time_series.save
  end
  
  test "should not create TimeSeries without stock_price_id" do
    time_series = TimeSeries.new(symbol: 'ABC')
    assert_not time_series.save
  end
  
  test "should create a TimeSeries given symbol and stock_price_id" do
    time_series = TimeSeries.new(symbol: 'ABC', stock_price_id: StockPrice.last.id)
    assert time_series.save
  end
end
