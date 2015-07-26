class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :supplier_id
      t.date :date
      t.decimal :total_order_value
      t.string :local_currency_code
      t.decimal :local_value
      t.decimal :value

      t.timestamps null: false
    end
  end
end
