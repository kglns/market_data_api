require 'test_helper'

class DataServiceTest < ActiveSupport::TestCase
  test "extract data - time series" do
    test_response = File.open('test_response.txt', 'r').read
    data = DataService.extract(test_response, 'time_series')
    
    assert data.include? (:identifiers)
    assert data.include? (:data)
    assert data[:identifiers][:symbol] == 'IBM'
  end

  test "extract data - stock price" do
    test_response = File.open('test_response.txt', 'r').read
    data = DataService.extract(test_response, 'stock_price')
    
    assert data.include? (:identifiers)
    assert data.include? (:data)
    assert data[:identifiers][:symbol] == 'IBM'
  end
end