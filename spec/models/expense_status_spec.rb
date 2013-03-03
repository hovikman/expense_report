require 'spec_helper'

describe ExpenseStatus do
  
  context "attributes" do
    let(:expense_status) { FactoryGirl.build(:expense_status) }
    it "responds to #name" do
      expect(expense_status).to respond_to(:name)
    end
  end
    
  context "scope and number of rows" do
    let(:expense_statuses) { ExpenseStatus.all }
    it "number of ExpenseStatuses is 4" do 
      expect(expense_statuses.count).to eq(4)
    end
    it "first element is 'Approved'" do 
      expect(expense_statuses[0].name).to eq("Approved")
    end
    it "second element is 'Assigned to accounting'" do
      expect(expense_statuses[1].name).to eq("Assigned to accounting")
    end
    it "third element is 'Assigned to manager'" do
      expect(expense_statuses[2].name).to eq("Assigned to manager")
    end
    it "forth element is 'New'" do
      expect(expense_statuses[3].name).to eq("New")
    end
  end

  context "associations" do
    let(:expense_status) { FactoryGirl.create(:expense_status) }
    it "responds to expenses" do
      expect(expense_status).to respond_to(:expenses)
    end
    it "retrieves expenses" do
      expense = FactoryGirl.create(:expense, expense_status: expense_status)
      expect(expense_status.expenses).to eq([expense])
    end
  end
    
  context "validations" do
    let(:expense_status) { FactoryGirl.build(:expense_status) }
    it "requires name" do
      expense_status.name = ''
      expect(expense_status.errors[:name]).not_to be_nil
    end
    it "rejects names that are too long" do
      expense_status.name = "a" * 26
      expect(expense_status.errors[:name]).not_to be_nil
    end
    it "rejects duplicate names" do
      new_expense_status = FactoryGirl.create(:expense_status)
      expense_status.name = new_expense_status.name
      expect(expense_status.errors[:name]).not_to be_nil
    end
  end

  context "callbacks" do
    describe "attempt to delete expense_status when an expense refers to it" do
      let(:expense_status) { FactoryGirl.create(:expense_status) }
      it "raises error when expense_status deleted" do
        expect {
          FactoryGirl.create(:expense, expense_status: expense_status)
          expense_status.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete expense status '#{expense_status.name}'. There are expenses referencing this expense status."
          )
      end
    end
  end
      
  context "methods" do
    [:new_id, :assigned_to_manager_id, :assigned_to_accounting_id, :approved_id].each do |method|
      it "responds to #{method}" do
        expect(ExpenseStatus).to respond_to(method)
      end
      it "#{method} returns number" do
        expect(ExpenseStatus.send(method)).to be_a_kind_of(Fixnum)
      end
    end
  end
  
end