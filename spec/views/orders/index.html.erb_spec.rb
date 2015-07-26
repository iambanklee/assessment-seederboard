require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :customer_id => 1,
        :supplier_id => 2,
        :total_order_value => "9.99",
        :local_currency_code => "Local Currency Code",
        :local_value => "Local Value",
        :decimal => "Decimal",
        :value => "9.99"
      ),
      Order.create!(
        :customer_id => 1,
        :supplier_id => 2,
        :total_order_value => "9.99",
        :local_currency_code => "Local Currency Code",
        :local_value => "Local Value",
        :decimal => "Decimal",
        :value => "9.99"
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Local Currency Code".to_s, :count => 2
    assert_select "tr>td", :text => "Local Value".to_s, :count => 2
    assert_select "tr>td", :text => "Decimal".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
