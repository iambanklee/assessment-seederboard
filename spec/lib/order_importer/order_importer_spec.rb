require 'rails_helper'
require 'order_importer/order_importer'

describe OrderImporter do
  describe "::import" do
    it "imports all files in predefined folder" do
      expect(OrderImporter.import).not_to eq []
    end
  end
end