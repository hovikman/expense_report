require 'spec_helper'

describe Company do

  context "attributes" do
    let(:company) { FactoryGirl.build(:company) }
    [:accountant_id, :contact_email, :contact_person,
     :contact_phone, :contact_title, :currency_id, :name].each do |attr|
      it "responds to #{attr}" do
        company.should respond_to(attr)
      end
    end
  end

  context "associations" do
    let(:company) { FactoryGirl.build(:company) }
    [:users, :expense_types, :currency, :accountant].each do |assoc|
      it "responds to #{assoc}" do
        company.should respond_to(assoc)
      end
    end
    it "retrieves users" do
      user = FactoryGirl.create(:user)
      company = user.company
      company.users.should == [user]
    end
    it "retrieves expense_types" do
      expense_type = FactoryGirl.create(:expense_type)
      company = expense_type.company
      company.expense_types.should == [expense_type]
    end
    it "retrieves currency" do
      currency = FactoryGirl.create(:currency)
      company.currency_id = currency.id
      company.currency.should == currency
    end
    it "retrieves accountant" do
      company.save
      accountant = FactoryGirl.create(:user, company: company)
      company.accountant_id = accountant.id
      company.accountant.should == accountant
    end
  end

  context "validations" do
    let(:company) { FactoryGirl.build(:company) }
    [:name, :contact_person, :contact_title, :contact_phone, :contact_email, :currency_id].each do |attr|
      it "requires #{attr}" do
        company[attr] = nil
        company.should_not be_valid
        company.errors[attr].should_not be_nil
      end
    end
    it "rejects names that are too long" do
      company.name = "a" * 31
      company.should_not be_valid
      company.errors[:name].should_not be_nil
    end
    it "rejects duplicate names" do
      new_company = FactoryGirl.create(:company)
      company.name = new_company.name
      company.should_not be_valid
      company.errors[:name].should_not be_nil
    end
    it "rejects contact_persons that are too long" do
      company.contact_person = "a" * 31
      company.should_not be_valid
      company.errors[:contact_person].should_not be_nil
    end
    it "rejects contact_titles that are too long" do
      company.contact_title = "a" * 21
      company.should_not be_valid
       company.errors[:contact_title].should_not be_nil
    end
    it "rejects contact_phones that are too long" do
      company.contact_phone = "a" * 21
      company.should_not be_valid
      company.errors[:contact_phone].should_not be_nil
    end
    it "rejects contact_emails that are too long" do
      company.contact_email = "a" * 41
      company.should_not be_valid
      company.errors[:contact_email].should_not be_nil
    end
    it "rejects invalid contact_emails" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |email|
        company.contact_email = email
        company.should_not be_valid
        company.errors[:contact_email].should_not be_nil
      end      
    end
    it "accepts valid contact_emails" do
      emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |email|
        company.contact_email = email
        company.should be_valid
        company.should have(:no).error_on(:contact_email)
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
        vendor_company.save.should == false
      end
      it "generates error message on :name when 'vendor' company is renamed" do
        vendor_company.name = 'some other name'
        vendor_company.save
        #vendor_company.errors.include?(:name).should == true
        vendor_company.errors[:name].should_not be nil
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

  context "methods" do
    it "responds to #vendor_id" do
      Company.should respond_to :vendor_id
    end
    it "#vendor_id returns correct value" do
      Company.find(Company.vendor_id).name.should == 'Vendor'
    end
  end

end