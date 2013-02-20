require 'spec_helper'

describe Company do

  describe "attributes" do
    before(:each) do
      @company = FactoryGirl.build(:company)
    end
    it "responds to #accountant_id" do
      @company.should respond_to(:accountant_id)
    end
    it "responds to #contact_email" do
      @company.should respond_to(:contact_email)
    end
    it "responds to #contact_person" do
      @company.should respond_to(:contact_person)
    end
    it "responds to #contact_phone" do
      @company.should respond_to(:contact_phone)
    end
    it "responds to #contact_title" do
      @company.should respond_to(:contact_title)
    end
    it "responds to #currency_id" do
      @company.should respond_to(:currency_id)
    end
    it "responds to #name" do
      @company.should respond_to(:name)
    end
  end

  describe "associations" do
    before(:each) do
      @company = FactoryGirl.build(:company)
    end
    it "responds to #users" do
      @company.should respond_to :users
    end
    it "responds to #expense_types" do
      @company.should respond_to :expense_types
    end
    it "responds to #currency" do
      @company.should respond_to :currency
    end
    it "responds to #accountant" do
      @company.should respond_to :accountant
    end
    it "tests related to 'users' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'expense_types' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'currency' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'accountant' association" do
      pending "need more time to understand how to do it"
    end
  end

  describe "validations" do
    before(:each) do
      @company = FactoryGirl.build(:company)
    end
    it "requires name" do
      @company.name = ''
      @company.should_not be_valid
      @company.should have(1).error_on(:name)
    end
    it "rejects names that are too long" do
      @company.name = "a" * 31
      @company.should_not be_valid
      @company.should have(1).error_on(:name)
    end
    it "rejects duplicate names" do
      company = FactoryGirl.create(:company)
      @company.name = company.name
      @company.should_not be_valid
      @company.should have(1).error_on(:name)
    end
    it "requires currency_id" do
      @company.currency_id = nil
      @company.should_not be_valid
      @company.should have(1).error_on(:currency_id)
    end
    it "requires contact_person" do
      @company.contact_person = ''
      @company.should_not be_valid
      @company.should have(1).error_on(:contact_person)
    end
    it "rejects contact_persons that are too long" do
      @company.contact_person = "a" * 31
      @company.should_not be_valid
      @company.should have(1).error_on(:contact_person)
    end
    it "requires contact_title" do
      @company.contact_title = ''
      @company.should_not be_valid
      @company.should have(1).error_on(:contact_title)
    end
    it "rejects contact_titles that are too long" do
      @company.contact_title = "a" * 21
      @company.should_not be_valid
      @company.should have(1).error_on(:contact_title)
    end
    it "requires contact_phone" do
      @company.contact_phone = ''
      @company.should_not be_valid
      @company.should have(1).error_on(:contact_phone)
    end
    it "rejects contact_phones that are too long" do
      @company.contact_phone = "a" * 21
      @company.should_not be_valid
      @company.should have(1).error_on(:contact_phone)
    end
    it "requires contact_email" do
      @company.contact_email = ''
      @company.should_not be_valid
      @company.should have_at_least(1).error_on(:contact_email)
    end

    it "rejects contact_emails that are too long" do
      @company.contact_email = "a" * 41
      @company.should_not be_valid
      @company.should have_at_least(1).error_on(:contact_email)
    end
    it "rejects invalid contact_emails" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |email|
        @company.contact_email = email
        @company.should_not be_valid
        @company.should have(1).error_on(:contact_email)
      end      
    end
    it "accepts valid contact_emails" do
      emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |email|
        @company.contact_email = email
        @company.should be_valid
        @company.should have(:no).error_on(:contact_email)
      end
    end      
  end

  describe "callbacks" do
    describe "attempt to delete 'vendor' company" do
      before(:each) do
        @vendor_company = Company.find(Company.vendor_id)
      end
      it "raises error when 'vendor' company is deleted" do
        expect {
          @vendor_company.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete the vendor company."
          )
      end
      it "number of records in Companies table is not changed when attempted to delete 'vendor' company" do
        expect {
          begin
            @vendor_company.destroy
          rescue RuntimeError
          end
        }.to_not change(Company, :count)
      end
      it "callback #ensure_cannot_delete_vendor is called when attempted to delete 'vendor' company" do
        @vendor_company.should_receive(:ensure_cannot_delete_vendor)      
        begin
          @vendor_company.destroy
        rescue RuntimeError
        end
      end
    end
    
    describe "attempt to rename 'vendor' company" do
      before(:each) do
        @vendor_company = Company.find(Company.vendor_id)
      end
      it "callback #ensure_vendor_name_not_changed is called when attempted to rename 'vendor' company" do
        @vendor_company.should_receive(:ensure_vendor_name_not_changed)
        @vendor_company.name = 'some other name'
        @vendor_company.save
      end
      it "fails to save 'vendor' company when name is changed" do
        @vendor_company.name = 'some other name'
        @vendor_company.save.should == false
      end
      it "generates error message on :name when 'vendor' company is renamed" do
        @vendor_company.name = 'some other name'
        @vendor_company.save
        @vendor_company.should have(1).error
        pending('@vendor_company.should have(1).error_on(:name)')
      end
    end

    it "calls downcase on 'contact_email' field before save" do
      company = FactoryGirl.build(:company)
      mixed_case_email = "Foo@ExAMPle.CoM"
      company.contact_email = mixed_case_email
      company.save
      company.reload.contact_email.should == mixed_case_email.downcase
    end

    it "tests related to #ensure_not_referenced_by_any_user callback" do
      pending "need more time to understand how to do it"
    end
    it "tests related to #ensure_not_referenced_by_any_expense_type callback" do
      pending "need more time to understand how to do it"
    end
  end

  describe "methods" do
    it "responds to #vendor_id" do
      Company.should respond_to :vendor_id
    end
    it "#vendor_id returns correct value" do
      Company.find(Company.vendor_id).name.should == 'Vendor'
    end
  end

end