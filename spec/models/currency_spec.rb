require 'spec_helper'

describe Currency do

  before(:each) do
    @attr = {
      name: "Example Currency",
      code: "AAA"
    }
  end
  
  describe "attributes" do
    it "should create a new instance given a valid attribute" do
      Currency.create!(@attr)
    end
    describe "should respond to"
      before(:each) do
        @currency = Currency.new(@attr)
      end
      it "should respond to #name" do
        @currency.should respond_to(:name)
      end
      it "should respond to #code" do
        @currency.should respond_to(:code)
      end
  end
    
  describe "associations" do
    currency = Currency.new(@attr)
    it { currency.should respond_to :companies }
    it { currency.should respond_to :expense_details }
    it "tests related to Company association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to ExpenseDetail association" do
      pending "need more time to understand how to do it"
    end
  end
    
  describe "validations" do
    describe "name validations" do
      it "should require a name" do
        no_name_currency = Currency.new(@attr.merge(name: ""))
        no_name_currency.should_not be_valid
      end
    
      it "should reject names that are too long" do
        long_name = "a" * 31
        long_name_currency = Currency.new(@attr.merge(name: long_name))
        long_name_currency.should_not be_valid
      end
  
      it "should reject duplicate names" do
        Currency.create!(@attr)
        currency_with_duplicate_name = Currency.new({name: @attr[:name], code: 'A01'})
        currency_with_duplicate_name.should_not be_valid
      end
    end
    
    describe "code validations" do
      it "should require a code" do
        no_code_currency = Currency.new(@attr.merge(code: ""))
        no_code_currency.should_not be_valid
      end
    
      it "should reject codes that are too long" do
        long_code = "a" * 4
        long_code_currency = Currency.new(@attr.merge(code: long_code))
        long_code_currency.should_not be_valid
      end
  
      it "should reject duplicate codes" do
        Currency.create!(@attr)
        currency_with_duplicate_code = Currency.new({name: 'Example Currency2', code: @attr[:code]})
        currency_with_duplicate_code.should_not be_valid
      end
    end
  end

  describe "callbacks" do
    it "tests related to Currency callbacks" do
      pending "need more time to understand how to do it"
    end
  end
      
  describe "methods" do
    before(:each) do
      @currency = Currency.new(@attr)
    end
    describe "should responde to :code_and_name" do
      it { @currency.should respond_to :code_and_name }
    end
    describe ":code_and_name should return correct value" do
      it { @currency.code_and_name.should == 'AAA Example Currency' }
    end
  end
  
end