require 'spec_helper'

describe Company do

  context "attributes" do
    let(:company) { FactoryGirl.build(:company) }
    [:accountant_id, :contact_email, :contact_person,
     :contact_phone, :contact_title, :currency_id, :name].each do |attr|
      it "responds to #{attr}" do
        expect(company).to respond_to(attr)
      end
    end
  end

  context "associations" do
    let(:company) { FactoryGirl.create(:company) }
    [:users, :expense_types, :currency, :accountant].each do |assoc|
      it "responds to #{assoc}" do
        expect(company).to respond_to(assoc)
      end
    end
    it "retrieves users" do
      user = FactoryGirl.create(:user, company: company)
      expect(company.users).to eq([user])
    end
    it "retrieves expense_types" do
      expense_type = FactoryGirl.create(:expense_type, company: company)
      expect(company.expense_types).to eq([expense_type])
    end
    it "retrieves currency" do
      currency = FactoryGirl.create(:currency)
      company.currency_id = currency.id
      expect(company.currency).to eq(currency)
    end
    it "retrieves accountant" do
      company.save
      accountant = FactoryGirl.create(:user, company: company)
      company.accountant_id = accountant.id
      expect(company.accountant).to eq(accountant)
    end
  end

  context "validations" do
    let(:company) { FactoryGirl.build(:company) }
    [:name, :contact_person, :contact_title, :contact_phone, :contact_email, :currency_id].each do |attr|
      it "requires #{attr}" do
        company[attr] = nil
        expect(company.errors[attr]).to_not be_nil
      end
    end
    it "rejects names that are too long" do
      company.name = "a" * 31
      expect(company.errors[:name]).not_to be_nil
    end
    it "rejects duplicate names" do
      new_company = FactoryGirl.create(:company)
      company.name = new_company.name
      expect(company.errors[:name]).not_to be_nil
    end
    it "rejects contact_persons that are too long" do
      company.contact_person = "a" * 31
      expect(company.errors[:contact_person]).not_to be_nil
    end
    it "rejects contact_titles that are too long" do
      company.contact_title = "a" * 21
      expect(company.errors[:contact_title]).not_to be_nil
    end
    it "rejects contact_phones that are too long" do
      company.contact_phone = "a" * 21
      expect(company.errors[:contact_phone]).not_to be_nil
    end
    it "rejects contact_emails that are too long" do
      company.contact_email = "a" * 41
      expect(company.errors[:contact_email]).not_to be_nil
    end
    it "rejects invalid contact_emails" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |email|
        company.contact_email = email
        expect(company.errors[:contact_email]).not_to be_nil
      end      
    end
    it "accepts valid contact_emails" do
      emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |email|
        company.contact_email = email
        expect(company).to be_valid
      end
    end      
  end

  context "callbacks" do
    describe "attempt to delete 'vendor' company" do
      let(:vendor_company) { Company.find(Company.vendor_id) }
      it "raises error when 'vendor' company is deleted" do
        expect {
          vendor_company.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete the vendor company."
          )
      end
      it "number of records in Companies table is not changed when attempted to delete 'vendor' company" do
        expect {
          begin
            vendor_company.destroy
          rescue RuntimeError
          end
        }.to_not change(Company, :count)
      end
      it "callback #ensure_cannot_delete_vendor is called when attempted to delete 'vendor' company" do
        vendor_company.should_receive(:ensure_cannot_delete_vendor)      
        begin
          vendor_company.destroy
        rescue RuntimeError
        end
      end
    end
    
    describe "attempt to rename 'vendor' company" do
      let(:vendor_company) { Company.find(Company.vendor_id) }
      it "callback #ensure_vendor_name_not_changed is called when attempted to rename 'vendor' company" do
        vendor_company.should_receive(:ensure_vendor_name_not_changed)
        vendor_company.name = 'some other name'
        vendor_company.save
      end
      it "fails to save 'vendor' company when name is changed" do
        vendor_company.name = 'some other name'
        expect(vendor_company.save).to be false
      end
      it "generates error message on :name when 'vendor' company is renamed" do
        vendor_company.name = 'some other name'
        vendor_company.save
        expect(vendor_company.errors[:name]).not_to be_nil
      end
    end

    it "calls downcase on 'contact_email' field before save" do
      company = FactoryGirl.build(:company)
      mixed_case_email = "Foo@ExAMPle.CoM"
      company.contact_email = mixed_case_email
      company.save
      expect(company.reload.contact_email).to eq(mixed_case_email.downcase)
    end

    describe "attempt to delete company with expense_types" do
      let(:company) { FactoryGirl.create(:company) }
      it "raises error when company with expense_types deleted" do
        expect {
          FactoryGirl.create(:expense_type, company: company)
          company.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete company '#{company.name}'. There are expense types referencing this company."
          )
      end
    end

    describe "attempt to delete company with users" do
      let(:company) { FactoryGirl.create(:company) }
      it "raises error when company with users deleted" do
        expect {
          FactoryGirl.create(:user, company: company)
          company.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete company '#{company.name}'. There are users referencing this company."
          )
      end
    end
  end

  context "methods" do
    it "responds to #vendor_id" do
      expect(Company).to respond_to(:vendor_id)
    end
    it "#vendor_id returns correct value" do
      expect(Company.find(Company.vendor_id).name).to eq('Vendor')
    end
  end

end