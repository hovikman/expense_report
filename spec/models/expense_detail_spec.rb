require 'spec_helper'

describe ExpenseDetail do

  context "attributes" do
    let(:expense_detail) { build(:expense_detail) }
    [:amount, :comments, :currency_id, :date, :exchange_rate, :expense_id, :expense_type_id].each do |attr|
      it "responds to #{attr}" do
        expect(expense_detail).to respond_to(attr)
      end
    end
  end

  context "scope" do
    it "responds to #for_datatable" do
      expect(ExpenseDetail).to respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        create(:expense_detail)
        @expense_detail = ExpenseDetail.for_datatable.first
      end
      [:id, :date, :type_name, :total_amount].each do |attr|
        it "responds to #{attr}" do
          expect(@expense_detail).to respond_to(attr)
        end
      end
    end
  end

  context "associations" do
    let(:expense_detail) { build(:expense_detail) }
    [:currency, :expense, :expense_type].each do |assoc|
      it "responds to #{assoc}" do
        expect(expense_detail).to respond_to(assoc)
      end
    end
    it "retrieves currency" do
      currency = create(:currency)
      expense_detail.currency_id = currency.id
      expect(expense_detail.currency).to eq(currency)
    end
    it "retrieves expense" do
      expense = create(:expense)
      expense_detail.expense_id = expense.id
      expect(expense_detail.expense).to eq(expense)
    end
    it "retrieves expense_type" do
      expense_type = create(:expense_type)
      expense_detail.expense_type_id = expense_type.id
      expect(expense_detail.expense_type).to eq(expense_type)
    end
  end

  context "validations" do
    let(:expense_detail) { build(:expense_detail) }
    [:amount, :currency_id, :date, :exchange_rate, :expense_id, :expense_type_id].each do |attr|
      it "requires #{attr}" do
        expense_detail[attr] = nil
        expect(expense_detail.errors[attr]).not_to be_nil
      end
    end
    it "rejects 0 amounts" do
      expense_detail.amount = 0.0
      expect(expense_detail.errors[:amount]).not_to be_nil
    end
    it "rejects negative amounts" do
      expense_detail.amount = -5.0
      expect(expense_detail.errors[:amount]).not_to be_nil
    end
    it "rejects 0 exchange_rate" do
      expense_detail.exchange_rate = 0.0
      expect(expense_detail.errors[:exchange_rate]).not_to be_nil
    end
    it "rejects negative exchange_rate" do
      expense_detail.exchange_rate = -5.0
      expect(expense_detail.errors[:exchange_rate]).not_to be_nil
    end
  end
  
  context "default values" do
    let(:expense_detail) { ExpenseDetail.new }
    it "default value of amount is 0.0" do
      expect(expense_detail.amount).to eq(0.0)
    end
    it "default value of date is today" do
      expect(expense_detail.date).to eq(DateTime.now.to_date)
    end
    it "default value of exchange_rate is 1.0" do
      expect(expense_detail.exchange_rate).to eq(1.00)
    end
  end

end