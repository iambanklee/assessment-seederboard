class AddCurrecyRateToOrder < ActiveRecord::Migration
  def change
    add_column  :orders, :to_gbp_rate, :decimal
  end
end
