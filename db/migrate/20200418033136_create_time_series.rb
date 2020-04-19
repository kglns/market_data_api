class CreateTimeSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_series do |t|
      t.string :closing_date
      t.float :close
      t.float :adjusted_close
      t.string :symbol

      t.timestamps
    end
  end
end
