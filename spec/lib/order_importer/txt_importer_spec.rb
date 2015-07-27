require 'rails_helper'
require 'order_importer/txt_importer'

describe OrderImporter::TxtImporter do

  describe "::import" do
    file   = File.open("#{Rails.root}/data/order_5.txt", "r")
    result = OrderImporter::TxtImporter.import(file)
    it { expect(result).to eq true }
  end

end