require 'spec_helper'

describe Currency do

  describe "attributes" do
    it "creates new instance given a valid attribute" do
      Currency.create!(FactoryGirl.attributes_for(:currency))
    end
    currency = FactoryGirl.build(:currency)
    it "responds to #name" do
      currency.should respond_to(:name)
    end
    it "responds to #code" do
      currency.should respond_to(:code)
    end
  end

  describe "associations" do
    currency = FactoryGirl.build(:currency)
    it "responds to #companies" do
      currency.should respond_to :companies
    end
    it "responds to #expense_details" do
      currency.should respond_to :expense_details
    end
    it "tests related to Company association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to ExpenseDetail association" do
      pending "need more time to understand how to do it"
    end
  end

  describe "validations" do
    it "requires name" do
      currency = FactoryGirl.build(:currency)
      currency.should be_valid
      currency.name = ''
      currency.should_not be_valid
    end

    it "rejects names that are too long" do
      currency = FactoryGirl.build(:currency)
      currency.should be_valid
      currency.name = "a" * 31
      currency.should_not be_valid
    end

    it "rejects duplicate names" do
      currency = FactoryGirl.create(:currency)
      currency_with_duplicate_name = FactoryGirl.build(:currency)
      currency_with_duplicate_name.name = currency.name
      currency_with_duplicate_name.should_not be_valid
    end

    it "requires code" do
      currency = FactoryGirl.build(:currency)
      currency.should be_valid
      currency.code = ''
      currency.should_not be_valid
    end

    it "rejects codes that are too long" do
      currency = FactoryGirl.build(:currency)
      currency.should be_valid
      currency.code = "a" * 4
      currency.should_not be_valid
    end

    it "rejects duplicate codes" do
      currency = FactoryGirl.create(:currency)
      currency_with_duplicate_code = FactoryGirl.build(:currency)
      currency_with_duplicate_code.code = currency.code
      currency_with_duplicate_code.should_not be_valid
    end
  end

  describe "callbacks" do
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

  describe "methods" do
    currency = FactoryGirl.build(:currency)
    it "responds to #code_and_name" do
      currency.should respond_to :code_and_name
    end
    it "#code_and_name returns correct value" do
      currency.code_and_name.should == currency.code + ' ' + currency.name
    end
  end

end