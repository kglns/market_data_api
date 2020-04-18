module DataService

    require 'net/http'

    def self.fetch
        url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=IBM&apikey=demo"
        uri = URI(url)
        response = Net::HTTP.get_response uri
    end

    def self.extract res
        if res.code == '200'
            data_hash = JSON.parse(res.body)
            if data_hash.include? 'Meta Data'
                meta_data = data_hash['Meta Data']
                @info = meta_data['1. Information']
                @symbol = meta_data['2. Symbol']
                @last_refreshed = meta_data['3. Last Refreshed']
                @time_zone = meta_data['5. Time Zone']
            end
            if data_hash.include? 'Time Series (Daily)'
                time_series = data_hash['Time Series (Daily)'][@last_refreshed]
                data = {
                    :symbol => @symbol,
                    :open => time_series['1. open'],
                    :high => time_series['2. high'],
                    :low => time_series['3. low'],
                    :close => time_series['4. close'],
                    :adjusted_close => time_series['5. adjusted close'],
                    :volume => time_series['6. volume'],
                    :dividend_amount => time_series['7. dividend amount'],
                    :split_coefficient => time_series['8. split coefficient'],
                }
            end
        end
    end

    def self.load(model, identifier, data)
        object = model.find_by_symbol(identifier)
        if object
            object.update_attributes(data)
        else
            model.create(data)
        end
    end

    def self.run
        data = self.extract(self.fetch)
        self.load(StockPrice, data[:symbol], data)
    end
end