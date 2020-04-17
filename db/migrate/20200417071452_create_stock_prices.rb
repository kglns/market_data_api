class CreateStockPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_prices do |t|

      t.timestamps
    end
  end
end
