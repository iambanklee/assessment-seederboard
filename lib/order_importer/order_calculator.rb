require 'open_exchange_rate_checker'

module OrderImporter
  module OrderCalculator
    def calculate(order_hash)
      order_date        = order_hash[:date]
      currency_code     = order_hash[:local_currency_code]
      total_order_value = order_hash[:total_order_value]

      order_hash[:value] = calculate_value(get_gbp_rate(order_date, currency_code), total_order_value)
    end

    def get_gbp_rate(order_date, currency_code)
      return 1.0 if currency_code == 'GBP'

      rate_checker = OpenExchangeRateChecker::RateChecker.new
      gbp_rate     = rate_checker.get_date_rate(order_date, 'GBP')

      case currency_code
      when 'USD'
        gbp_rate
      else
        # Other currency -> USD -> GBP due to the free API account cannot change the base currency
        other_rate = rate_checker.get_date_rate(order_date, currency_code)
        (other_rate / gbp_rate).round(6)
      end
    end

    def calculate_value(currency_rate, original_value)
      (original_value.to_f / currency_rate.to_f).round(2)
    end
  end
end