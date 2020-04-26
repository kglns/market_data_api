module DataService

    require 'net/http'

    def self.fetch url
        # url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=IBM&apikey=demo"
        uri = URI(url)
        response = Net::HTTP.get_response uri
    end

    def self.extract(res, type)
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
                if type == 'time_series'
                    time_series = data_hash['Time Series (Daily)']
                    final_time_series = []
                    time_series.each_pair do |closing_date, ts|
                        data = {
                            :symbol => @symbol,
                            :closing_date => closing_date,
                            :open => ts['1. open'],
                            :high => ts['2. high'],
                            :low => ts['3. low'],
                            :close => ts['4. close'],
                            :adjusted_close => ts['5. adjusted close'],
                            :volume => ts['6. volume'],
                            :dividend_amount => ts['7. dividend amount'],
                            :split_coefficient => ts['8. split coefficient'],
                        }
                        final_time_series << data
                    end
                    return {
                        :identifiers => {:symbol => @symbol},
                        :data => final_time_series
                    }
                elsif type == 'stock_price'
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
                    return {
                        :identifiers => {:symbol => @symbol},
                        :data => [data]
                    }
                else
                    p 'type must be time_series or intraday'
                end
            end
        end
    end

    def self.load(data_object, model)
        identifiers = data_object[:identifiers]
        data = data_object[:data]
        if identifiers && data
            data.each do |item|
                if model.name == "TimeSeries"
                    identifiers.update({:closing_date => item[:closing_date]})
                end
                object = model.find_by(identifiers)
                if object
                    object.update(item)
                else
                    model.create(item)
                end
            end
        end
    end

    def self.run url
        result = self.fetch(url)
        st_data = self.extract(result, 'stock_price')
        self.load(st_data, StockPrice)
        ts_data = self.extract(result, 'time_series')
        self.load(ts_data, TimeSeries)
    end
end