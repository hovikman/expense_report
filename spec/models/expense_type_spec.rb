require 'spec_helper'

describe ExpenseType do

  describe "attributes" do
    it "creates new instance given a valid attribute" do
      ExpenseType.create!(FactoryGirl.attributes_for(:expense_type))
    end
    expense_type = FactoryGirl.build(:expense_type)
    it "responds to #name" do
      expense_type.should respond_to(:name)
    end
    it "responds to #company_id" do
      expense_type.should respond_to(:company_id)
    end
  end

  describe "scope and number of rows" do
    it "responds to #for_datatable" do
      ExpenseType.should respond_to(:for_datatable)
    end
    it "has at least 10 rows" do
      ExpenseType.for_datatable.count.should >= 10
    end
    describe "elements of for_datatable scope" do
      subject { ExpenseType.for_datatable.first }
      it "responds to #id" do
        should respond_to(:id)
      end
      it "responds to #name" do
        should respond_to(:name)
      end
      it "responds to #company_name" do
        should respond_to(:company_name)
      end
    end
  end
  
  describe "associations" do
    expense_type = FactoryGirl.build(:expense_type)
    it "responds to #expense_details" do
      expense_type.should respond_to :expense_details
    end
    it "responds to #company" do
      expense_type.should respond_to :company
    end
    it "tests related to ExpenseDetail association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to Company association" do
      pending "need more time to understand how to do it"
    end
  end

  describe "validations" do
    it "requires name" do
      expense_type = FactoryGirl.build(:expense_type)
      expense_type.should be_valid
      expense_type.name = ''
      expense_type.should_not be_valid
      expense_type.should have(1).error_on(:name)
    end

    it "rejects names that are too long" do
      expense_type = FactoryGirl.build(:expense_type)
      expense_type.should be_valid
      expense_type.name = "a" * 31
      expense_type.should_not be_valid
      expense_type.should have(1).error_on(:name)
    end

    it "rejects duplicate names in the same company scope" do
      expense_type = FactoryGirl.create(:expense_type)
      expense_type_with_duplicate_name = FactoryGirl.build(:expense_type)
      expense_type_with_duplicate_name.name = expense_type.name
      expense_type_with_duplicate_name.should_not be_valid
      expense_type_with_duplicate_name.should have(1).error_on(:name)
    end

    it "appcepts duplicate names in different company scopes" do
      expense_type = FactoryGirl.create(:expense_type)
      company = FactoryGirl.create(:company)
      expense_type_with_duplicate_name = FactoryGirl.build(:expense_type, { name: expense_type.name, company: company })
      expense_type_with_duplicate_name.should be_valid
      expense_type_with_duplicate_name.should have(:no).error_on(:name)
    end
    
    it "requires company_id" do
      expense_type = FactoryGirl.build(:expense_type)
      expense_type.should be_valid
      expense_type.company_id = nil
      expense_type.should_not be_valid
      expense_type.should have(1).error_on(:company_id)
    end
  end

  describe "callbacks" do
    it "tests related to ExpenseType callbacks" do
      pending "need more time to understand how to do it"
    end
  end

end