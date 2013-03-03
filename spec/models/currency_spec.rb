require 'spec_helper'

describe Currency do

  context "attributes" do
    let(:currency) { FactoryGirl.build(:currency) }
    [:name, :code].each do |attr|
      it "responds to #{attr}" do
        expect(currency).to respond_to(attr)
      end
    end
  end

  context "associations" do
    let(:currency) { FactoryGirl.create(:currency) }
    [:companies, :expense_details].each do |assoc|
      it "responds to #{assoc}" do
        expect(currency).to respond_to(assoc)
      end
    end
    it "retrieves companies" do
      company = FactoryGirl.create(:company, currency: currency)
      expect(currency.companies).to eq([company])
    end
    it "retrieves expense_details" do
      expense_detail = FactoryGirl.create(:expense_detail, currency: currency)
      expect(currency.expense_details).to eq([expense_detail])
    end
  end

  context "validations" do
    let(:currency) { FactoryGirl.build(:currency) }
    [:name, :code].each do |attr|
      it "requires #{attr}" do
        currency[attr] = nil
        expect(currency.errors[attr]).not_to be_nil
      end
    end
    it "rejects names that are too long" do
      currency.name = "a" * 31
      expect(currency.errors[:name]).not_to be_nil
    end
    it "rejects duplicate names" do
      new_currency = FactoryGirl.create(:currency)
      currency.name = new_currency.name
      expect(currency.errors[:name]).not_to be_nil
    end
    it "rejects codes that are too long" do
      currency.code = "a" * 4
      expect(currency.errors[:code]).not_to be_nil
    end
    it "rejects duplicate codes" do
      new_currency = FactoryGirl.create(:currency)
      currency.code = new_currency.code
      expect(currency.errors[:code]).not_to be_nil
    end
  end

  context "callbacks" do
    it "calls upcase on 'code' field before save" do
      currency = FactoryGirl.build(:currency)
      code = currency.code
      currency.code.downcase!
      currency.save
      expect(currency.code).to eq(code)
    end
    describe "attempt to delete currency when a company refers to it" do
      let(:currency) { FactoryGirl.create(:currency) }
      it "raises error when currency deleted" do
        expect {
          FactoryGirl.create(:company, currency: currency)
          currency.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete currency '#{currency.name}'. There are companies referencing this currency."
          )
      end
    end
    describe "attempt to delete currency when an expense_detail refers to it" do
      let(:currency) { FactoryGirl.create(:currency) }
      it "raises error when currency deleted" do
        expect {
          FactoryGirl.create(:expense_detail, currency: currency)
          currency.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete currency '#{currency.name}'. There are expens details referencing this currency."
          )
      end
    end
  end

  context "methods" do
    let(:currency) { FactoryGirl.build(:currency) }
    it "responds to #code_and_name" do
      expect(currency).to respond_to(:code_and_name)
    end
    it "#code_and_name returns correct value" do
      expect(currency.code_and_name).to eq(currency.code + ' ' + currency.name)
    end
  end

end