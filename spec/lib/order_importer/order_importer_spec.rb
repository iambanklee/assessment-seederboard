require 'rails_helper'
require 'order_importer/order_importer'

describe OrderImporter do
  describe "::import" do
    it "imports all files in predefined folder" do
      expect(OrderImporter.import).to eq []
    end
  end

  describe "::file_queue" do
    it "list all files awaiting for importing" do
      expect(OrderImporter.file_queue).to eq []
    end
  end
end