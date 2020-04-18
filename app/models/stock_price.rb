class StockPrice < ApplicationRecord
    validate :symbol, presence: true, uniqueness: true
end
