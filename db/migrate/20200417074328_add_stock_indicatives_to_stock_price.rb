class AddStockIndicativesToStockPrice < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_prices, :open, :float
    add_column :stock_prices, :high, :float
    add_column :stock_prices, :low, :float
    add_column :stock_prices, :close, :float
    add_column :stock_prices, :adjusted_close, :float
    add_column :stock_prices, :volume, :int8
    add_column :stock_prices, :dividend_amount, :float
    add_column :stock_prices, :split_coefficient, :float
  end
end
