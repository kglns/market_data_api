class AddColumnsToTimeSeries < ActiveRecord::Migration[6.0]
  def change
    add_column :time_series, :open, :float
    add_column :time_series, :high, :float
    add_column :time_series, :low, :float
    add_column :time_series, :volume, :float
    add_column :time_series, :dividend_amount, :float
    add_column :time_series, :split_coefficient, :float
  end
end
