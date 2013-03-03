require 'spec_helper'

describe Expense do

  context "attributes" do
    let(:expense) { FactoryGirl.build(:expense) }
    [:advance_pay, :expense_status_id, :owner_id, :purpose, :submit_date, :user_id].each do |attr|
      it "responds to #{attr}" do
        expect(expense).to respond_to(attr)
      end
    end
  end

  context "scope" do
    it "responds to #for_datatable" do
      expect(Expense).to respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        FactoryGirl.create(:expense)
        @expense = Expense.for_datatable.first
      end
      [:id, :user_name, :submit_date, :purpose, :status_name, :total_amount].each do |attr|
        it "responds to #{attr}" do
          expect(@expense).to respond_to(attr)
        end
      end
    end
  end

  context "associations" do
    let(:expense) { FactoryGirl.create(:expense) }
    [:expense_details, :expense_attachments, :user, :expense_status, :owner].each do |assoc|
      it "responds to #{assoc}" do
        expect(expense).to respond_to(assoc)
      end
    end
    it "retrieves expense_details" do
      expense_detail = FactoryGirl.create(:expense_detail, expense: expense)
      expect(expense.expense_details).to eq([expense_detail])
    end
    it "deletes expense_details when expense is deleted" do
      FactoryGirl.create(:expense_detail, expense: expense)
      expect {
        expense.destroy
      }.to change {ExpenseDetail.count}.by(-1)
    end
    it "retrieves expense_attachments" do
      expense_attachment = FactoryGirl.create(:expense_attachment, expense: expense)
      expect(expense.expense_attachments).to eq([expense_attachment])
    end
    it "deletes expense_attachments when expense is deleted" do
      FactoryGirl.create(:expense_attachment, expense: expense)
      expect {
        expense.destroy
      }.to change {ExpenseAttachment.count}.by(-1)
    end
    it "retrieves user" do
      user = FactoryGirl.create(:user)
      expense.user_id = user.id
      expect(expense.user).to eq(user)
    end
    it "retrieves expense_status" do
      expense_status = FactoryGirl.create(:expense_status)
      expense.expense_status_id = expense_status.id
      expect(expense.expense_status).to eq(expense_status)
    end
    it "retrieves owner" do
      owner = FactoryGirl.create(:user)
      expense.owner_id = owner.id
      expect(expense.owner).to eq(owner)
    end
  end

  context "validations" do
    let(:expense) { FactoryGirl.build(:expense) }
    [:advance_pay, :expense_status_id, :purpose, :submit_date, :user_id].each do |attr|
      it "requires #{attr}" do
        expense[attr] = nil
        expect(expense.errors[attr]).not_to be_nil
      end
    end
    it "rejects negative advance_pay" do
      expense.advance_pay = -5.0
      expect(expense.errors[:advance_pay]).not_to be_nil
    end
    it "rejects purposes that are too long" do
      expense.purpose = "a" * 41
      expect(expense.errors[:purpose]).not_to be_nil
    end
  end
  
  context "default values" do
    let(:expense) { Expense.new }
    it "default value of advance_pay is 0.0" do
      expect(expense.advance_pay).to eq(0.0)
    end
    it "default value of submit_date is today" do
      expect(expense.submit_date).to eq(DateTime.now.to_date)
    end
  end
  
end