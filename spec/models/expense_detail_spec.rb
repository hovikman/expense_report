require 'spec_helper'

describe ExpenseDetail do

  context "attributes" do
    let(:expense_detail) { FactoryGirl.build(:expense_detail) }
    [:amount, :comments, :currency_id, :date, :exchange_rate, :expense_id, :expense_type_id].each do |attr|
      it "responds to #{attr}" do
        expense_detail.should respond_to(attr)
      end
    end
  end

  context "scope" do
    it "responds to #for_datatable" do
      ExpenseDetail.should respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        FactoryGirl.create(:expense_detail)
        @expense_detail = ExpenseDetail.for_datatable.first
      end
      [:id, :date, :type_name, :total_amount].each do |attr|
        it "responds to #{attr}" do
          @expense_detail.should respond_to(attr)
        end
      end
    end
  end

  context "associations" do
    let(:expense_detail) { FactoryGirl.build(:expense_detail) }
    [:currency, :expense, :expense_type].each do |assoc|
      it "responds to #{assoc}" do
        expense_detail.should respond_to(assoc)
      end
    end
    it "retrieves currency" do
      currency = FactoryGirl.create(:currency)
      expense_detail.currency_id = currency.id
      expense_detail.currency.should == currency
    end
    it "retrieves expense" do
      expense = FactoryGirl.create(:expense)
      expense_detail.expense_id = expense.id
      expense_detail.expense.should == expense
    end
    it "retrieves expense_type" do
      expense_type = FactoryGirl.create(:expense_type)
      expense_detail.expense_type_id = expense_type.id
      expense_detail.expense_type.should == expense_type
    end
  end

  context "validations" do
    let(:expense_detail) { FactoryGirl.build(:expense_detail) }
    [:amount, :currency_id, :date, :exchange_rate, :expense_id, :expense_type_id].each do |attr|
      it "requires #{attr}" do
        expense_detail[attr] = nil
        expense_detail.should_not be_valid
        expense_detail.errors[attr].should_not be_nil
      end
    end
    it "rejects 0 amounts" do
      expense_detail.amount = 0.0
      expense_detail.should_not be_valid
      expense_detail.errors[:amount].should_not be_nil
    end
    it "rejects negative amounts" do
      expense_detail.amount = -5.0
      expense_detail.should_not be_valid
      expense_detail.errors[:amount].should_not be_nil
    end
    it "rejects 0 exchange_rate" do
      expense_detail.exchange_rate = 0.0
      expense_detail.should_not be_valid
      expense_detail.errors[:exchange_rate].should_not be_nil
    end
    it "rejects negative exchange_rate" do
      expense_detail.exchange_rate = -5.0
      expense_detail.should_not be_valid
      expense_detail.errors[:exchange_rate].should_not be_nil
    end
  end
  
  context "default values" do
    let(:expense_detail) { ExpenseDetail.new }
    it "default value of amount is 0.0" do
      expense_detail.amount.should == 0.0
    end
    it "default value of date is today" do
      expense_detail.date.should == DateTime.now.to_date
    end
    it "default value of exchange_rate is 1.0" do
      expense_detail.exchange_rate.should == 1.00
    end
  end

end