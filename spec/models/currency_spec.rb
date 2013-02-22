require 'spec_helper'

describe Currency do

  context "attributes" do
    let(:currency) { FactoryGirl.build(:currency) }
    [:name, :code].each do |attr|
      it "responds to #{attr}" do
        currency.should respond_to(attr)
      end
    end
  end

  context "associations" do
    let(:currency) { FactoryGirl.build(:currency) }
    [:companies, :expense_details].each do |assoc|
      it "responds to #{assoc}" do
        currency.should respond_to(assoc)
      end
      it "tests related to #{assoc} association" do
        pending "need more time to understand how to do it"
      end
    end
  end

  context "validations" do
    let(:currency) { FactoryGirl.build(:currency) }
    [:name, :code].each do |attr|
      it "requires #{attr}" do
        currency[attr] = nil
        currency.should_not be_valid
        currency.errors[attr].should_not be_nil
      end
    end
    it "rejects names that are too long" do
      currency.name = "a" * 31
      currency.should_not be_valid
      currency.errors[:name].should_not be_nil
    end
    it "rejects duplicate names" do
      new_currency = FactoryGirl.create(:currency)
      currency.name = new_currency.name
      currency.should_not be_valid
      currency.errors[:name].should_not be_nil
    end
    it "rejects codes that are too long" do
      currency.code = "a" * 4
      currency.should_not be_valid
      currency.errors[:code].should_not be_nil
    end
    it "rejects duplicate codes" do
      new_currency = FactoryGirl.create(:currency)
      currency.code = new_currency.code
      currency.should_not be_valid
      currency.errors[:code].should_not be_nil
    end
  end

  context "callbacks" do
    it "calls upcase on 'code' field before save" do
      currency = FactoryGirl.build(:currency)
      code = currency.code
      currency.code.downcase!
      currency.save
      currency.code.should == code
    end
    it "tests related to Currency callbacks" do
      pending "need more time to understand how to do it"
    end
  end

  context "methods" do
    let(:currency) { FactoryGirl.build(:currency) }
    it "responds to #code_and_name" do
      currency.should respond_to :code_and_name
    end
    it "#code_and_name returns correct value" do
      currency.code_and_name.should == currency.code + ' ' + currency.name
    end
  end

end