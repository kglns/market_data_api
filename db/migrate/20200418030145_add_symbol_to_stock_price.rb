class AddSymbolToStockPrice < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_prices, :symbol, :string
  end
end
