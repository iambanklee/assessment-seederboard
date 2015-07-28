require 'rails_helper'
require 'order_importer/txt_importer'

describe OrderImporter::TxtImporter do

  describe "::import" do
    file   = File.open("#{Rails.root}/data/order_5.txt", "r")
    result = OrderImporter::TxtImporter.import(file)
    it { should_not eq true }
  end

end