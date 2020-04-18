class StockPrice < ApplicationRecord
    validates :symbol, presence: true, uniqueness: true
    has_many :time_series
end
