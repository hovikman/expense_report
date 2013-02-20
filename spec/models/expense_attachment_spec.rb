require 'spec_helper'

describe ExpenseAttachment do

  describe "attributes" do
    let(:expense_attachment) { FactoryGirl.build(:expense_attachment) }
    it "responds to #description" do
      expense_attachment.should respond_to(:description)
    end
    it "responds to #expense_id" do
      expense_attachment.should respond_to(:expense_id)
    end
    it "responds to #file_path" do
      expense_attachment.should respond_to(:file_path)
    end
  end

  describe "associations" do
    let(:expense_attachment) { FactoryGirl.build(:expense_attachment) }
    it "responds to #expense" do
      expense_attachment.should respond_to :expense
    end
    it "tests related to 'expense' association" do
      pending "need more time to understand how to do it"
    end
  end

  describe "validations" do
    let(:expense_attachment) { FactoryGirl.build(:expense_attachment) }
    it "requires description" do
      expense_attachment.description = ''
      expense_attachment.should_not be_valid
      expense_attachment.should have(1).error_on(:description)
    end
    it "rejects descriptions that are too long" do
      expense_attachment.description = "a" * 41
      expense_attachment.should_not be_valid
      expense_attachment.should have(1).error_on(:description)
    end
    it "requires expense_id" do
      expense_attachment.expense_id = nil
      expense_attachment.should_not be_valid
      expense_attachment.should have(1).error_on(:expense_id)
    end
    it "requires file_path" do
      pending "need more time to understand how to do it"
    end
  end

  it "tests related to uploader" do
    pending "need more time to understand how to do it"
  end

end