require 'spec_helper'

describe ExpenseDetail do

  describe "attributes" do
    before(:each) do
      @expense_detail = FactoryGirl.build(:expense_detail)
    end
    it "responds to #amount" do
      @expense_detail.should respond_to(:amount)
    end
    it "responds to #comments" do
      @expense_detail.should respond_to(:comments)
    end
    it "responds to #currency_id" do
      @expense_detail.should respond_to(:currency_id)
    end
    it "responds to #date" do
      @expense_detail.should respond_to(:date)
    end
    it "responds to #exchange_rate" do
      @expense_detail.should respond_to(:exchange_rate)
    end
    it "responds to #expense_id" do
      @expense_detail.should respond_to(:expense_id)
    end
    it "responds to #expense_type_id" do
      @expense_detail.should respond_to(:expense_type_id)
    end
  end

  describe "scope" do
    it "responds to #for_datatable" do
      ExpenseDetail.should respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        FactoryGirl.create(:expense_detail)
        @expense_detail = ExpenseDetail.for_datatable.first
      end
      it "responds to #id" do
        @expense_detail.should respond_to(:id)
      end
      it "responds to #date" do
        @expense_detail.should respond_to(:date)
      end
      it "responds to #type_name" do
        @expense_detail.should respond_to(:type_name)
      end
      it "responds to #total_amount" do
        @expense_detail.should respond_to(:total_amount)
      end
    end
  end

  describe "associations" do
    before(:each) do
      @expense_detail = FactoryGirl.build(:expense_detail)
    end
    it "responds to #currency" do
      @expense_detail.should respond_to :currency
    end
    it "responds to #expense" do
      @expense_detail.should respond_to :expense
    end
    it "responds to #expense_type" do
      @expense_detail.should respond_to :expense_type
    end
    it "tests related to 'currency' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'expense' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'expense_type' association" do
      pending "need more time to understand how to do it"
    end
  end

  describe "validations" do
    before(:each) do
      @expense_detail = FactoryGirl.build(:expense_detail)
    end
    it "requires amount" do
      @expense_detail.amount = nil
      @expense_detail.should_not be_valid
      @expense_detail.should have(2).error_on(:amount)
    end
    it "rejects 0 amounts" do
      @expense_detail.amount = 0.0
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:amount)
    end
    it "rejects negative amounts" do
      @expense_detail.amount = -5.0
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:amount)
    end
    it "requires currency_id" do
      @expense_detail.currency_id = nil
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:currency_id)
    end
    it "requires date" do
      @expense_detail.date = nil
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:date)
    end
    it "requires exchange_rate" do
      @expense_detail.exchange_rate = nil
      @expense_detail.should_not be_valid
      @expense_detail.should have(2).error_on(:exchange_rate)
    end
    it "rejects 0 exchange_rate" do
      @expense_detail.exchange_rate = 0.0
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:exchange_rate)
    end
    it "rejects negative exchange_rate" do
      @expense_detail.exchange_rate = -5.0
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:exchange_rate)
    end
    it "requires expense_id" do
      @expense_detail.expense_id = nil
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:expense_id)
    end
    it "requires expense_type_id" do
      @expense_detail.expense_type_id = nil
      @expense_detail.should_not be_valid
      @expense_detail.should have(1).error_on(:expense_type_id)
    end
  end
  
  describe "default values" do
    before(:each) do
      @expense_detail = ExpenseDetail.new
    end
    it "default value of amount is 0.0" do
      @expense_detail.amount.should == 0.0
    end
    it "default value of date is today" do
      @expense_detail.date.should == DateTime.now.to_date
    end
    it "default value of exchange_rate is 1.0" do
      @expense_detail.exchange_rate.should == 1.00
    end
  end

end