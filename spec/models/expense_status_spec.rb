require 'spec_helper'

describe ExpenseStatus do
  
  describe "attributes" do
    let(:expense_status) { FactoryGirl.build(:expense_status) }
    it "responds to #name" do
      expense_status.should respond_to(:name)
    end
  end
    
  describe "scope and number of rows" do
    let(:expense_statuses) { ExpenseStatus.all }
    it "number of ExpenseStatuses is 4" do 
      expense_statuses.count.should == 4
    end
    it "first element is 'Approved'" do 
      expense_statuses[0].name.should == "Approved"
    end
    it "second element is 'Assigned to accounting'" do
      expense_statuses[1].name.should == "Assigned to accounting"
    end
    it "third element is 'Assigned to manager'" do
      expense_statuses[2].name.should == "Assigned to manager"
    end
    it "forth element is 'New'" do
      expense_statuses[3].name.should == "New"
    end
  end

  describe "associations" do
    it "responds to :expenses" do
      pending "need more time to understand how to use factories"
    end
    it "tests related to Expense association" do
      pending "need more time to understand how to do it"
    end
  end
    
  describe "validations" do
    let(:expense_status) { FactoryGirl.build(:expense_status) }
    it "requires name" do
      expense_status.name = ''
      expense_status.should_not be_valid
      expense_status.errors[:name].should_not be_nil
    end
    it "rejects names that are too long" do
      expense_status.name = "a" * 26
      expense_status.should_not be_valid
      expense_status.errors[:name].should_not be_nil
    end
    it "rejects duplicate names" do
      new_expense_status = FactoryGirl.create(:expense_status)
      expense_status.name = new_expense_status.name
      expense_status.should_not be_valid
      expense_status.errors[:name].should_not be_nil
    end
  end

  describe "callbacks" do
    it "tests related to Expense callbacks" do
      pending "need more time to understand how to do it"
    end
  end
      
  describe "methods" do
    it "responds to #new_id" do
      ExpenseStatus.should respond_to :new_id
    end
    it "responds to #assigned_to_manager_id" do
      ExpenseStatus.should respond_to :assigned_to_manager_id
    end
    it "responds to #assigned_to_accounting_id" do
      ExpenseStatus.should respond_to :assigned_to_accounting_id
    end
    it "responds to #approved_id" do
      ExpenseStatus.should respond_to :approved_id
    end
    it "#new_id returns number" do
      ExpenseStatus.new_id.should be_a_kind_of(Fixnum)
    end
    it "#assigned_to_manager_id returns number" do
      ExpenseStatus.assigned_to_manager_id.should be_a_kind_of(Fixnum)
    end
    it "#assigned_to_accounting_id returns number" do
      ExpenseStatus.assigned_to_accounting_id.should be_a_kind_of(Fixnum)
    end
    it "#approved_id returns number" do
      ExpenseStatus.approved_id.should be_a_kind_of(Fixnum)
    end
  end
  
end