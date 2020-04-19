class AddStockPriceToTimeSeries < ActiveRecord::Migration[6.0]
  def change
    add_reference :time_series, :stock_price, foreign_key: true
  end
end
