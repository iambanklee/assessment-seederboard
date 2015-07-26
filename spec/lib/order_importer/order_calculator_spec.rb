require 'spec_helper'
require 'order_importer/order_calculator'

class TestOrderCalculator
  include OrderImporter::OrderCalculator
end

describe TestOrderCalculator do
  let(:order_calculator) { TestOrderCalculator.new }
  let(:order_hash) { {date: '2015-05-07', local_currency_code: 'USD', total_order_value: 1023.00, value: nil} }

  describe "#calculate" do
    subject { order_calculator.calculate(order_hash) }

    context "date: '2015-05-07', local_currency_code: 'USD', total_order_value: 1,023.00" do
      it {should eq 1575.52}
    end

    context "date: '2015-05-07', local_currency_code: 'EUR', total_order_value: 1,023.00" do
      let(:order_hash) { {date: '2015-05-07', local_currency_code: 'EUR', total_order_value: 1023.00, value: nil} }
      it {should eq 746.89}
    end
  end

  describe "#get_gbp_rate" do
    subject { order_calculator.get_gbp_rate(date, currency_code) }

    context "when 2015-05-07, GBP" do
      let(:date)  { '2015-05-07' }
      let(:currency_code) { 'GBP' }
      it { should eq 1 }
    end

    context "when 2015-05-07, USD" do
      let(:date)  { '2015-05-07' }
      let(:currency_code) { 'USD' }
      it { should eq 0.649309 }
    end

    context "when 2015-05-07, EUR" do
      let(:date)  { '2015-05-07' }
      let(:currency_code) { 'EUR' }
      it { should eq 1.369685 }
    end
  end

  describe "#calculate_value" do
    subject { order_calculator.calculate_value(currency_rate, original_value) }

    context "when currency_rate=1 , original_value=1000" do
      let(:currency_rate)  { 1 }
      let(:original_value) { 1000 }
      it { should eq 1000 }
    end
    context "when currency_rate=0.6438 , original_value=1000" do
      let(:currency_rate)  { 0.6438 }
      let(:original_value) { 1000 }
      it { should eq 1553.28 }
    end
    context "currency_rate=30.753 , original_value=1000" do
      let(:currency_rate)  { 30.753 }
      let(:original_value) { 1000 }
      it { should eq 32.52 }
    end
  end
end