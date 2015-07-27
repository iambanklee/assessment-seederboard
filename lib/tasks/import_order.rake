require 'order_importer/order_importer'

namespace :import do
  task :orders => :environment do |t|
    OrderImporter.import
  end
end