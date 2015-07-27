require 'rails_helper'
require 'order_importer/convertible'

class TestConvertible
  include OrderImporter::Convertible
end

describe TestConvertible do
  let(:converter) { TestConvertible.new }

  describe "#convert_date" do
    subject { converter.convert_date(date_string) }

    context "when '24/08/2014' " do
      let(:date_string) { '24/08/2014' }
      it {should eq '2014-08-24'}
    end

    context "when 'Sat, 10 Nov 2007' " do
      let(:date_string) { 'Sat, 10 Nov 2007' }
      it {should eq '2007-11-10'}
    end

    context "when '8/24/2014' " do
      let(:date_string) { '8/24/2014' }
      it {should eq '2014-08-24'}
    end

    context "when '4/11/2015' " do
      let(:date_string) { '4/11/2015' }
      it {should eq '2015-04-11'}
    end
  end

  describe "#curreny_to_gbp" do
    subject { converter.curreny_to_gbp(eur_curreny) }

    context "when EUR 1.893,23 " do
      let(:eur_curreny) { '1.893,23' }
      it {should eq '1,893.23'}
      it {should_not eq '1.893,23'}
    end

    context "when EUR 1.272.893,23 " do
      let(:eur_curreny) { '1.272.893,23' }
      it {should eq '1,272,893.23'}
      it {should_not eq '1.272.893,23'}
    end

    context "when USD 12345678.90 " do
      let(:eur_curreny) { '12345678.90' }
      it {should eq '12,345,678.90'}
      it {should_not eq '12345678.90'}
    end

    context "when USD 1234567890 " do
      let(:eur_curreny) { '1234567890' }
      it {should eq '1,234,567,890.00'}
      it {should_not eq '1234567890'}
    end
  end

end