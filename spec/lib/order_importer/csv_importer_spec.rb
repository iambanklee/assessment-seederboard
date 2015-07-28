require 'rails_helper'
require 'order_importer/csv_importer'

describe OrderImporter::CsvImporter do

  describe "::import" do
    file   = File.open("#{Rails.root}/data/order_1.csv", "r")
    result = OrderImporter::CsvImporter.import(file)
    it { should_not eq true }

    file   = File.open("#{Rails.root}/data/order_2.csv", "r")
    result = OrderImporter::CsvImporter.import(file)
    it { should_not eq true }

    file   = File.open("#{Rails.root}/data/order_3.csv", "r")
    result = OrderImporter::CsvImporter.import(file)
    it { should_not eq eq true }

    file   = File.open("#{Rails.root}/data/order_4.csv", "r")
    result = OrderImporter::CsvImporter.import(file)
    it { should_not eq eq true }
  end

end