require 'order_importer/order_importer'

namespace :order do
  task :import => :environment do |t|
    OrderImporter.import
  end

  task :reset => :environment do |t|
    Order.delete_all
  end

  task :reload => :environment do |t|
    Order.delete_all
    OrderImporter.import
  end
end
