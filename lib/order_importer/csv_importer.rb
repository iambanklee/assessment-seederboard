require 'csv'
require 'order_importer/order_calculator'

module OrderImporter
  module CsvImporter
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
      order_hash[:total_order_value]   = row["Currency"] == 'EUR' ? eur_curreny_to_gbp(row["Total Order Value"]) : row["Total Order Value"]

      calculate(order_hash)
    end

    def self.convert_date(date_string)
      converted_date = nil
      date_formats.each do |date_format|
        begin
          converted_date = Date.strptime(date_string, date_format)
          break
        rescue ArgumentError
          next
        end
      end

      # Use date format %Y-%m-%d to be stored in database
      # To avoid the format not match database localisation
      converted_date.strftime("%Y-%m-%d")
    end

    # Define the converting order of date format
    # If a date 4/11/2015 will use mm/dd/yyyy rule
    def self.date_formats
      [
        '%m/%d/%Y', #'mm/dd/yyyy',
        '%m-%d-%Y', #'mm-dd-yyyy',
        '%m-%d-%y', #'mm-dd-yy',
        '%d/%m/%Y', #'dd/mm/yyyy',
        '%d-%m-%Y', #'dd-mm-yyyy',
        '%d-%m-%y', #'dd-mm-yy',
        '%a, %d %b %Y' #strftime, e.g. 'Sat, 10 Nov 2007'
      ]
    end

    def self.eur_curreny_to_gbp(curreny_string)
      integer, decimal = curreny_string.split(',')
      integer.gsub!('.',',')
      "#{integer}.#{decimal}"
    end

  end
end