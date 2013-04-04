require 'spec_helper'

describe RejectNote do

  context "attributes" do
    let(:reject_note) { build(:reject_note) }
    [:content, :date, :expense_id, :sender_id].each do |attr|
      it "responds to #{attr}" do
        expect(reject_note).to respond_to(attr)
      end
    end
  end

  context "scope" do
    it "responds to #for_datatable" do
      expect(RejectNote).to respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        create(:reject_note)
        @reject_note = ExpenseDetail.for_datatable.first
      end
      [:id, :sender, :date, :content].each do |attr|
        it "responds to #{attr}" do
          expect(@reject_note).to respond_to(attr)
        end
      end
    end
  end
  
  context "associations" do
    let(:reject_note) { build(:reject_note) }
    it "responds to #{assoc}" do
      expect(reject_note).to respond_to(:expense)
    end
    it "retrieves expense" do
      expense = create(:expense)
      reject_note.expense_id = expense.id
      expect(reject_note.expense).to eq(expense)
    end
  end

  context "validations" do
    let(:reject_note) { build(:reject_note) }
    [:date, :expense_id].each do |attr|
      it "requires #{attr}" do
        reject_note[attr] = nil
        expect(reject_note.errors[attr]).not_to be_nil
      end
    end
  end

  context "default values" do
    let(:reject_note) {RejectNote.new }
    it "default value of date is today" do
      expect(reject_note.date).to eq(DateTime.now.to_date)
    end
  end

end