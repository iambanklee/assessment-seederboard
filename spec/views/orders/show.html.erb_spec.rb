require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :customer_id => 1,
      :supplier_id => 2,
      :total_order_value => "9.99",
      :local_currency_code => "Local Currency Code",
      :local_value => "Local Value",
      :decimal => "Decimal",
      :value => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Local Currency Code/)
    expect(rendered).to match(/Local Value/)
    expect(rendered).to match(/Decimal/)
    expect(rendered).to match(/9.99/)
  end
end
