require 'spec_helper'

describe ExpenseStatus do
  
  context "attributes" do
    let(:expense_status) { FactoryGirl.build(:expense_status) }
    it "responds to #name" do
      expense_status.should respond_to(:name)
    end
  end
    
  context "scope and number of rows" do
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

  context "associations" do
    it "responds to :expenses" do
      pending "need more time to understand how to use factories"
    end
    it "tests related to Expense association" do
      pending "need more time to understand how to do it"
    end
  end
    
  context "validations" do
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

  context "callbacks" do
    it "tests related to Expense callbacks" do
      pending "need more time to understand how to do it"
    end
  end
      
  context "methods" do
    [:new_id, :assigned_to_manager_id, :assigned_to_accounting_id, :approved_id].each do |method|
      it "responds to #{method}" do
        ExpenseStatus.should respond_to(method)
      end
      it "#{method} returns number" do
        ExpenseStatus.send(method).should be_a_kind_of(Fixnum)
      end
    end
  end
  
end