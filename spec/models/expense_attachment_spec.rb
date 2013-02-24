require 'spec_helper'

describe ExpenseAttachment do

  context "attributes" do
    let(:expense_attachment) { FactoryGirl.build(:expense_attachment) }
    [:description, :expense_id, :file_path].each do |attr|
      it "responds to #{attr}" do
        expense_attachment.should respond_to(attr)
      end
    end
  end

  context "associations" do
    let(:expense_attachment) { FactoryGirl.build(:expense_attachment) }
    it "responds to #expense" do
      expense_attachment.should respond_to :expense
    end
    it "retrieves expense" do
      expense = FactoryGirl.create(:expense)
      expense_attachment.expense_id = expense.id
      expense_attachment.expense.should == expense
    end
  end

  context "validations" do
    let(:expense_attachment) { FactoryGirl.build(:expense_attachment) }
    [:description, :expense_id].each do |attr|
      it "requires #{attr}" do
        expense_attachment[attr] = nil
        expense_attachment.should_not be_valid
        expense_attachment.errors[attr].should_not be_nil
      end
    end
    it "rejects descriptions that are too long" do
      expense_attachment.description = "a" * 41
      expense_attachment.should_not be_valid
      expense_attachment.errors[:description].should_not be_nil
    end
    it "requires file_path" do
      pending "need more time to understand how to do it"
    end
  end

  it "tests related to uploader" do
    pending "need more time to understand how to do it"
  end

end