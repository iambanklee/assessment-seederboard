require 'csv'

module OrderImporter
  module CsvImporter
    extend OrderImporter::Convertible
    extend OrderImporter::OrderCalculator

    def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
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