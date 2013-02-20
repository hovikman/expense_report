require 'spec_helper'

describe Currency do

  describe "attributes" do
    let(:currency) { FactoryGirl.build(:currency) }
    it "responds to #name" do
      currency.should respond_to(:name)
    end
    it "responds to #code" do
      currency.should respond_to(:code)
    end
  end

  describe "associations" do
    let(:currency) { FactoryGirl.build(:currency) }
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
    let(:currency) { FactoryGirl.build(:currency) }
    it "requires name" do
      currency.name = ''
      currency.should_not be_valid
      currency.should have(1).error_on(:name)
    end
    it "rejects names that are too long" do
      currency.name = "a" * 31
      currency.should_not be_valid
      currency.should have(1).error_on(:name)
    end
    it "rejects duplicate names" do
      new_currency = FactoryGirl.create(:currency)
      currency.name = new_currency.name
      currency.should_not be_valid
      currency.should have(1).error_on(:name)
    end
    it "requires code" do
      currency.code = ''
      currency.should_not be_valid
      currency.should have(1).error_on(:code)
    end
    it "rejects codes that are too long" do
      currency.code = "a" * 4
      currency.should_not be_valid
      currency.should have(1).error_on(:code)
    end
    it "rejects duplicate codes" do
      new_currency = FactoryGirl.create(:currency)
      currency.code = new_currency.code
      currency.should_not be_valid
      currency.should have(1).error_on(:code)
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
    let(:currency) { FactoryGirl.build(:currency) }
    it "responds to #code_and_name" do
      currency.should respond_to :code_and_name
    end
    it "#code_and_name returns correct value" do
      currency.code_and_name.should == currency.code + ' ' + currency.name
    end
  end

end