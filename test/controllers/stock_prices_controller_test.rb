require 'test_helper'

class StockPricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_price = stock_prices(:one)
  end

  test "should get index" do
    get stock_prices_url, as: :json
    assert_response :success
  end

  test "should create stock_price" do
    assert_difference('StockPrice.count') do
      post stock_prices_url, params: { stock_price: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show stock_price" do
    get stock_price_url(@stock_price), as: :json
    assert_response :success
  end

  test "should update stock_price" do
    patch stock_price_url(@stock_price), params: { stock_price: {  } }, as: :json
    assert_response 200
  end

  test "should destroy stock_price" do
    assert_difference('StockPrice.count', -1) do
      delete stock_price_url(@stock_price), as: :json
    end

    assert_response 204
  end
end
