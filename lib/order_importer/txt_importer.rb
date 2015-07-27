require 'csv'

module OrderImporter
  module TxtImporter
    extend OrderImporter::Convertible
    extend OrderImporter::OrderCalculator

    # The Txt order format is similiar to Csv one but separated by ';'
    # So use Csv to parse the txt file
    def self.import(file)
      CSV.foreach(file.path, headers: true, col_sep: ";") do |row|
        order_hash = {}
        prepare_order(order_hash, row)

        Order.create(order_hash)
      end
    end

    def self.prepare_order(order_hash, row)
      order_hash[:date]        = convert_date(row["Order Date"])
      order_hash[:customer_id] = row["Customer ID"]
      order_hash[:supplier_id] = row["Supplier ID"]

      order_hash[:local_currency_code] = row["Currency"]
      order_hash[:total_order_value]   = curreny_to_gbp(row["Total Order Value"]).gsub(',','')

      # calculate(order_hash)
    end

  end
end