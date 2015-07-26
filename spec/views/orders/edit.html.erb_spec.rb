require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :customer_id => 1,
      :supplier_id => 1,
      :total_order_value => "9.99",
      :local_currency_code => "MyString",
      :local_value => "MyString",
      :decimal => "MyString",
      :value => "9.99"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_customer_id[name=?]", "order[customer_id]"

      assert_select "input#order_supplier_id[name=?]", "order[supplier_id]"

      assert_select "input#order_total_order_value[name=?]", "order[total_order_value]"

      assert_select "input#order_local_currency_code[name=?]", "order[local_currency_code]"

      assert_select "input#order_local_value[name=?]", "order[local_value]"

      assert_select "input#order_decimal[name=?]", "order[decimal]"

      assert_select "input#order_value[name=?]", "order[value]"
    end
  end
end
