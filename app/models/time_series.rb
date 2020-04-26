class TimeSeries < ApplicationRecord
    validates :symbol, presence: true, uniqueness: true
    belongs_to :stock_price
end
