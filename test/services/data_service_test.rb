require 'test_helper'

class DataServiceTest < ActiveSupport::TestCase
  SAMPLE_RESPONSE = File.open('test_response.txt', 'r').read
  test "extract data - time series" do
    data = DataService._extract(SAMPLE_RESPONSE, 'time_series')
    
    assert data.include? (:identifiers)
    assert data.include? (:data)
    assert data[:identifiers][:symbol] == 'IBM'
  end

  test "extract data - stock price" do
    test_response = File.open('test_response.txt', 'r').read
    data = DataService._extract(SAMPLE_RESPONSE, 'stock_price')
    
    assert data.include? (:identifiers)
    assert data.include? (:data)
    assert data[:identifiers][:symbol] == 'IBM'
  end

  test "extract method functionalities" do
    test_response = File.open('test_response.txt', 'r').read
    data = DataService.extract(SAMPLE_RESPONSE)
    
  end
end