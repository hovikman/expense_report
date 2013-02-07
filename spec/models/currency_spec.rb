require 'spec_helper'

describe Currency do

  describe "attributes" do
    it "should create a new instance given a valid attribute" do
      Currency.create!(FactoryGirl.attributes_for(:currency))
    end
    describe "should respond to" do
      before(:each) do
        @currency = FactoryGirl.build(:currency)
      end
      it "should respond to #name" do
        @currency.should respond_to(:name)
      end
      it "should respond to #code" do
        @currency.should respond_to(:code)
      end
    end
  end

  describe "associations" do
    currency = FactoryGirl.build(:currency)
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
        currency = FactoryGirl.build(:currency)
        currency.should be_valid
        currency.name = ''
        currency.should_not be_valid
      end

      it "should reject names that are too long" do
        currency = FactoryGirl.build(:currency)
        currency.should be_valid
        currency.name = "a" * 31
        currency.should_not be_valid
      end

      it "should reject duplicate names" do
        currency = FactoryGirl.create(:currency)
        currency_with_duplicate_name = FactoryGirl.build(:currency)
        currency_with_duplicate_name.name = currency.name
        currency_with_duplicate_name.should_not be_valid
      end
    end

    describe "code validations" do
      it "should require a code" do
        currency = FactoryGirl.build(:currency)
        currency.should be_valid
        currency.code = ''
        currency.should_not be_valid
      end

      it "should reject codes that are too long" do
        currency = FactoryGirl.build(:currency)
        currency.should be_valid
        currency.code = "a" * 4
        currency.should_not be_valid
      end

      it "should reject duplicate codes" do
        currency = FactoryGirl.create(:currency)
        currency_with_duplicate_code = FactoryGirl.build(:currency)
        currency_with_duplicate_code.code = currency.code
        currency_with_duplicate_code.should_not be_valid
      end
    end
  end

  describe "callbacks" do
    it "upcase should be called on 'code' before save" do
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
    before (:each) do
      @currency = FactoryGirl.build(:currency)
    end
    describe "should responde to :code_and_name" do
      it { @currency.should respond_to :code_and_name }
    end
    describe ":code_and_name should return correct value" do
      it { @currency.code_and_name.should == @currency.code + ' ' + @currency.name }
    end
  end

end