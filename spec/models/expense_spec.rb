require 'spec_helper'

describe Expense do

  describe "attributes" do
    before(:each) do
      @expense = FactoryGirl.build(:expense)
    end
    it "responds to #advance_pay" do
      @expense.should respond_to(:advance_pay)
    end
    it "responds to #expense_status_id" do
      @expense.should respond_to(:expense_status_id)
    end
    it "responds to #owner_id" do
      @expense.should respond_to(:owner_id)
    end
    it "responds to #purpose" do
      @expense.should respond_to(:purpose)
    end
    it "responds to #submit_date" do
      @expense.should respond_to(:submit_date)
    end
    it "responds to #user_id" do
      @expense.should respond_to(:user_id)
    end
  end

  describe "scope" do
    it "responds to #for_datatable" do
      Expense.should respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        FactoryGirl.create(:expense)
        @expense = Expense.for_datatable.first
      end
      it "responds to #id" do
        @expense.should respond_to(:id)
      end
      it "responds to #user_name" do
        @expense.should respond_to(:user_name)
      end
      it "responds to #submit_date" do
        @expense.should respond_to(:submit_date)
      end
      it "responds to #purpose" do
        @expense.should respond_to(:purpose)
      end
      it "responds to #status_name" do
        @expense.should respond_to(:status_name)
      end
      it "responds to #total_amount" do
        @expense.should respond_to(:total_amount)
      end
    end
  end

  describe "associations" do
    before(:each) do
      @expense = FactoryGirl.build(:expense)
    end
    it "responds to #expense_details" do
      @expense.should respond_to :expense_details
    end
    it "responds to #expense_attachments" do
      @expense.should respond_to :expense_attachments
    end
    it "responds to #user" do
      @expense.should respond_to :user
    end
    it "responds to #expense_status" do
      @expense.should respond_to :expense_status
    end
    it "responds to #owner" do
      @expense.should respond_to :owner
    end
    it "tests related to 'expense_details' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'expense_attachments' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'user' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'expense_status' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'owner' association" do
      pending "need more time to understand how to do it"
    end
  end

  describe "validations" do
    before(:each) do
      @expense = FactoryGirl.build(:expense)
    end
    it "requires advance_pay" do
      @expense.advance_pay = nil
      @expense.should_not be_valid
      @expense.should have(2).error_on(:advance_pay)
    end
    it "rejects negative advance_pay" do
      @expense.advance_pay = -5.0
      @expense.should_not be_valid
      @expense.should have(1).error_on(:advance_pay)
    end
    it "requires expense_status_id" do
      @expense.expense_status_id = nil
      @expense.should_not be_valid
      @expense.should have(1).error_on(:expense_status_id)
    end
    it "requires purpose" do
      @expense.purpose = ''
      @expense.should_not be_valid
      @expense.should have(1).error_on(:purpose)
    end
    it "rejects purposes that are too long" do
      @expense.purpose = "a" * 41
      @expense.should_not be_valid
      @expense.should have(1).error_on(:purpose)
    end
    it "requires submit_date" do
      @expense.submit_date = nil
      @expense.should_not be_valid
      @expense.should have(1).error_on(:submit_date)
    end
    it "requires user_id" do
      @expense.user_id = nil
      @expense.should_not be_valid
      @expense.should have(1).error_on(:user_id)
    end
  end
  
  describe "default values" do
    before(:each) do
      @expense = Expense.new
    end
    it "default value of advance_pay is 0.0" do
      @expense.advance_pay.should == 0.0
    end
    it "default value of submit_date is today" do
      @expense.submit_date.should == DateTime.now.to_date
    end
  end
  
end