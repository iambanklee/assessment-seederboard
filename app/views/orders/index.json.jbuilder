json.array!(@orders) do |order|
  json.extract! order, :id, :customer_id, :supplier_id, :date, :total_order_value, :local_currency_code, :local_value, :decimal, :value
  json.url order_url(order, format: :json)
end
