require 'spec_helper'

describe ExpenseStatus do

  before(:each) do
    @attr = {
      name: "Example ExpenseStatus"
    }
  end
  
  describe "attributes" do
    it "should create a new instance given a valid attribute" do
      ExpenseStatus.create!(@attr)
    end
    it "should respond to #name" do
      expense_status = ExpenseStatus.create!(@attr)
      expense_status.should respond_to(:name)
    end
  end
    
  describe "scope and number of rows" do
    expense_statuses = ExpenseStatus.all
    it "number of ExpenseStatuses should be 4" do 
      expense_statuses.count.should == 4
    end
    it "first element should be 'Approved'" do 
      expense_statuses[0].name.should == "Approved"
    end
    it "second element should be 'Assigned to accounting'" do
      expense_statuses[1].name.should == "Assigned to accounting"
    end
    it "third element should be 'Assigned to manager'" do
      expense_statuses[2].name.should == "Assigned to manager"
    end
    it "forth element should be 'New'" do
      expense_statuses[3].name.should == "New"
    end
  end

  describe "associations" do
    it "should respond to :expenses" do
      pending "need more time to understand how to use factories"
    end
    it "tests related to Expense association" do
      pending "need more time to understand how to do it"
    end
  end
    
  describe "validations" do
    it "should require a name" do
      no_name_expense_status = ExpenseStatus.new(@attr.merge(name: ""))
      no_name_expense_status.should_not be_valid
    end
  
    it "should reject names that are too long" do
      long_name = "a" * 26
      long_name_expense_status = ExpenseStatus.new(@attr.merge(name: long_name))
      long_name_expense_status.should_not be_valid
    end

    it "should reject duplicate names" do
      ExpenseStatus.create!(@attr)
      expense_status_with_duplicate_name = ExpenseStatus.new(@attr)
      expense_status_with_duplicate_name.should_not be_valid
    end
  end

  describe "callbacks" do
    it "tests related to Expense callbacks" do
      pending "need more time to understand how to do it"
    end
  end
      
  describe "methods" do
    describe "responds" do
      subject { ExpenseStatus }
      it { should respond_to :new_id }
      it { should respond_to :assigned_to_manager_id }
      it { should respond_to :assigned_to_accounting_id }
      it { should respond_to :approved_id }
    end
    describe "return types" do
      it "#new_id should return number" do
        ExpenseStatus.new_id.should be_a_kind_of(Fixnum)
      end
      it "#assigned_to_manager_id should return number" do
        ExpenseStatus.assigned_to_manager_id.should be_a_kind_of(Fixnum)
      end
      it "#assigned_to_accounting_id should return number" do
        ExpenseStatus.assigned_to_accounting_id.should be_a_kind_of(Fixnum)
      end
      it "#approved_id should return number" do
        ExpenseStatus.approved_id.should be_a_kind_of(Fixnum)
      end
    end
  end
  
end