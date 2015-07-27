json.array!(@orders) do |order|
  json.order do |json|
    json.id order.id

    json.customer do |json|
      json.id order.customer_id
    end

    json.supplier do |json|
      json.id order.supplier_id
    end

    json.date l(order.date, format: '%m-%d-%Y')

    json.total_order_value do |json|
      json.local_currency_code order.local_currency_code
      json.local_value         order.total_order_value
      json.value               order.value
    end

  end
end
