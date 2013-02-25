require 'spec_helper'

describe ExpenseType do

  context "attributes" do
    let(:expense_type) { FactoryGirl.build(:expense_type) }
    [:name, :company_id].each do |attr|
      it "responds to #{attr}" do
        expense_type.should respond_to(attr)
      end
    end
  end

  context "scope and number of rows" do
    it "responds to #for_datatable" do
      ExpenseType.should respond_to(:for_datatable)
    end
    it "has at least 10 rows" do
      ExpenseType.for_datatable.count.should >= 10
    end
    describe "elements of for_datatable scope" do
      let(:expense_type) { ExpenseType.for_datatable.first }
      [:id, :name, :company_name].each do |attr|
        it "responds to #{attr}" do
          expense_type.should respond_to(attr)
        end
      end
    end
  end
  
  context "associations" do
    let(:expense_type) { FactoryGirl.create(:expense_type) }
    [:expense_details, :company].each do |assoc|
      it "responds to #{assoc}" do
        expense_type.should respond_to(assoc)
      end
    end
    it "retrieves expense_details" do
      expense_detail = FactoryGirl.create(:expense_detail, expense_type: expense_type)
      expense_type.expense_details.should == [expense_detail]
    end
    it "retrieves company" do
      company = FactoryGirl.create(:company)
      expense_type.company_id = company.id
      expense_type.company.should == company
    end
  end

  context "validations" do
    let(:expense_type) { FactoryGirl.build(:expense_type) }
    [:name, :company_id].each do |attr|
      it "requires #{attr}" do
        expense_type[attr] = nil
        expense_type.should_not be_valid
        expense_type.errors[attr].should_not be_nil
      end
    end
    it "rejects names that are too long" do
      expense_type.name = "a" * 31
      expense_type.should_not be_valid
      expense_type.errors[:name].should_not be_nil
    end
    it "rejects duplicate names in the same company scope" do
      new_expense_type = FactoryGirl.create(:expense_type, company: expense_type.company)
      expense_type.name = new_expense_type.name
      expense_type.should_not be_valid
      expense_type.errors[:name].should_not be_nil
    end
    it "appcepts duplicate names in different company scopes" do
      company = FactoryGirl.create(:company)
      new_expense_type = FactoryGirl.create(:expense_type, company: company)
      expense_type.name = new_expense_type.name
      expense_type.should be_valid
      expense_type.errors[:name].should_not be_nil
    end
  end

  context "callbacks" do
    describe "attempt to delete expense_type when an expense_detail refers to it" do
      let(:expense_type) { FactoryGirl.create(:expense_type) }
      it "raises error when expense_type deleted" do
        expect {
          FactoryGirl.create(:expense_detail, expense_type: expense_type)
          expense_type.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete expense type '#{expense_type.name}'. There are expense details referencing this expense type."
          )
      end
    end
  end

end