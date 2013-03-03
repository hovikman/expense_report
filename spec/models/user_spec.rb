require 'spec_helper'

describe User do

  context "attributes" do
    let(:user) { FactoryGirl.build(:user) }
    [:authenticate, :company_id, :email, :id, :manager_id, :name,
     :password, :password_confirmation, :password_digest, :password_reset_sent_at,
     :password_reset_token, :phone, :remember_token, :user_type_id].each do |attr|
      it "responds to #{attr}" do
        expect(user).to respond_to(attr)
      end
    end
  end

  context "scope" do
    it "responds to #for_datatable" do
      expect(User).to respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        FactoryGirl.create(:user)
        @user = User.for_datatable.first
      end
      [:id, :name, :company_name, :user_type_name].each do |attr|
        it "responds to #{attr}" do
          expect(@user).to respond_to(attr)
        end
      end
    end
  end

  context "associations" do
    let(:user) { FactoryGirl.create(:user) }
    [:users, :expenses, :owned_expenses, :company, :manager, :user_type].each do |assoc|
      it "responds to #{assoc}" do
        expect(user).to respond_to(assoc)
      end
    end
    it "retrieves users" do
      employee = FactoryGirl.create(:user, manager_id: user.id)
      expect(user.users).to eq([employee])
    end
    it "retrieves expenses" do
      expense = FactoryGirl.create(:expense, user: user)
      expect(user.expenses).to eq([expense])
    end
    it "retrieves owned_expenses" do
      expense = FactoryGirl.create(:expense, user: user, owner: user)
      expect(user.owned_expenses).to eq([expense])
    end
    it "retrieves company" do
      company = FactoryGirl.create(:company)
      user.company_id = company.id
      expect(user.company).to eq(company)
    end
    it "retrieves manager" do
      manager = FactoryGirl.create(:user)
      user.manager_id = manager.id
      expect(user.manager).to eq(manager)
    end
    it "retrieves user_type" do
      user_type = FactoryGirl.create(:user_type)
      user.user_type_id = user_type.id
      expect(user.user_type).to eq(user_type)
    end
  end
  
  context "validations" do
    let(:user) { FactoryGirl.build(:user) }
    [:company_id, :name, :email, :user_type_id].each do |attr|
      it "requires #{attr}" do
        user[attr] = nil
        expect(user.errors[attr]).not_to be_nil
      end
    end
    it "rejects names that are too long" do
      user.name = "a" * 31
      expect(user.errors[:company_id]).not_to be_nil
    end
    it "rejects identical emails" do
      user.save
      user_new = FactoryGirl.build(:user)
      user_new.email = user.email.upcase
      expect(user_new.errors[:email]).not_to be_nil
    end
    it "rejects emails that are too long" do
      user.email = "a" * 41
      expect(user.errors[:email]).not_to be_nil
    end
    it "rejects invalid emails" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |email|
        user.email = email
        expect(user.errors[:email]).not_to be_nil
      end      
    end
    it "accepts valid emails" do
      emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |email|
        user.email = email
        expect(user).to be_valid
      end
    end      
    it "rejects phones that are too long" do
      user.phone = "a" * 21
      expect(user.errors[:phone]).not_to be_nil
    end
    it "rejects duplicate names in the same company scope" do
      new_user = FactoryGirl.create(:user, company: user.company)
      user.name = new_user.name
      expect(user.errors[:name]).not_to be_nil
    end
    it "appcepts duplicate names in different company scopes" do
      company = FactoryGirl.create(:company)
      new_user = FactoryGirl.create(:regular_user, company: company)
      user.name = new_user.name
      expect(user.errors[:name]).not_to be_nil
    end
    it "reject vendor admins for companies other than 'vendor'" do
      company = FactoryGirl.create(:company)
      vendor_admin = FactoryGirl.build(:vendor_admin, company: company)
      expect(vendor_admin.errors[:user_type_id]).not_to be_nil
    end
  end

  context "after_initialize" do
    let(:user) { User.new }
    it "password is not blank" do
      expect(user.password).not_to be_blank
    end
    it "password matches with password_confirmation" do
      expect(user.password).to eq(user.password_confirmation)
    end
  end

  context "callbacks" do
    let(:user) { FactoryGirl.build(:user) }
    it "calls downcase on 'email' field before save" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq(mixed_case_email.downcase)
    end
    it "generates remember_token" do
      user.save
      expect(user.remember_token).not_to be_blank
    end
    describe "attempt to delete user(manager) when a user refer to it" do
      let(:manager) { FactoryGirl.create(:user) }
      it "raises error when manager deleted" do
        expect {
          FactoryGirl.create(:user, company: manager.company, manager: manager)
          manager.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete user '#{manager.name}'. There are users referencing this user as manager."
          )
      end
    end
    describe "attempt to delete user with expenses" do
      let(:user) { FactoryGirl.create(:user) }
      it "raises error when user deleted" do
        expect {
          FactoryGirl.create(:expense, user: user)
          user.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete user '#{user.name}'. There are expenses referencing this user."
          )
      end
    end
    describe "attempt to delete user(accountant) when a company refer to it" do
      let(:company) { FactoryGirl.create(:company) }
      let(:user)    { FactoryGirl.create(:user, company: company) }
      it "raises error when user deleted" do
        expect {
          company.accountant_id = user.id
          user.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete user '#{user.name}'. The user is the accountant of the company."
          )
      end
    end
    describe "attempt to delete the last vendor_admin" do
      let(:admin)   { User.where("user_type_id=:vendor_admin_id", {vendor_admin_id: UserType.vendor_admin_id}).first }
      it "raises error when admin deleted" do
        expect {
          # user 'vendor_admin' is also the accountant of the vendor company,
          # to be able to test this example, account_id should be assigned to nil
          vendor = Company.find(Company.vendor_id)
          vendor.accountant_id = nil
          vendor.save
          admin.destroy
        }.to raise_error(
          RuntimeError,
          "Cannot delete last vendor admin."
          )
      end
    end
  end

  context "methods" do
    describe "respond" do
      let(:user) { FactoryGirl.build(:user) }
      [:vendor_admin?, :regular_user?, :company_admin?, :admin?, :guest?,
       :password_valid?, :manager_name, :name_with_company, :send_password_reset].each do |method|
        it "responds to #{method}" do
          expect(user).to respond_to(method)
        end
      end
    end
    describe "regular user" do
      let(:regular_user) { FactoryGirl.build(:regular_user) }
      it "is not vendor admin" do
        expect(regular_user.vendor_admin?).to be false
      end
      it "is regular user" do
        expect(regular_user.regular_user?).to be true
      end
      it "is not company admin" do
        expect(regular_user.company_admin?).to be false
      end
      it "is not admin" do
        expect(regular_user.admin?).to be false
      end
      it "is not guest" do
        expect(regular_user.guest?).to be false
      end
    end
    describe "company admin" do
      let(:company_admin) { FactoryGirl.build(:company_admin) }
      it "is not vendor admin" do
        expect(company_admin.vendor_admin?).to be false
      end
      it "is not regular user" do
        expect(company_admin.regular_user?).to be false
      end
      it "is company admin" do
        expect(company_admin.company_admin?).to be true
      end
      it "is admin" do
        expect(company_admin.admin?).to be true
      end
      it "is not guest" do
        expect(company_admin.guest?).to be false
      end
    end
    describe "vendor admin" do
      let(:vendor_admin) { FactoryGirl.build(:vendor_admin) }
      it "is vendor admin" do
        expect(vendor_admin.vendor_admin?).to be true
      end
      it "is not regular user" do
        expect(vendor_admin.regular_user?).to be false
      end
      it "is not company admin" do
        expect(vendor_admin.company_admin?).to be false
      end
      it "is admin" do
        expect(vendor_admin.admin?).to be true
      end
      it "is not guest" do
        expect(vendor_admin.guest?).to be false
      end
    end
    describe "guest" do
      let(:guest) { User.new }
      it "is not vendor admin" do
        expect(guest.vendor_admin?).to be false
      end
      it "is not regular user" do
        expect(guest.regular_user?).to be false
      end
      it "is not company admin" do
        expect(guest.company_admin?).to be false
      end
      it "is not admin" do
        expect(guest.admin?).to be false
      end
      it "is guest" do
        expect(guest.guest?).to be true
      end
    end
    describe "manager_name" do
      let(:user) { FactoryGirl.build(:user) }
      it "manager_name returns empty string when user dosn't have manager" do
        expect(user.manager_name).to be_blank
      end
      it "manager_name returns correct value when user has a manager" do
        manager = FactoryGirl.create(:user)
        user.manager_id = manager.id
        expect(user.manager_name).to eq(manager.name)
      end
    end
    describe "name_with_company" do
      let(:user) { FactoryGirl.build(:user) }
      it "name_with_company returns correct value" do
        manager = FactoryGirl.create(:user)
        expect(user.name_with_company).to eq("#{user.name}, #{user.company.name}")
      end
    end
    describe "send_password_reset" do
      pending "need more time to understand how to do it"
    end
  end
  
  context "authentication" do
    let(:user) { FactoryGirl.build(:user) }
    it "rejects when password and password_confirmation do not match" do
      user.password_confirmation = "mismatch"
      expect(user).not_to be_valid
    end
    it "rejects passwords that are too short" do
      user.password = user.password_confirmation = "a" * 5
      expect(user.password_valid?(user.password)).to be false
    end
    it "authenticates user with correct password" do
      user.save
      found_user = User.find_by_email(user.email)
      expect(user).to eq(found_user.authenticate(user.password))
    end
    it "doesn't authenticate user with invalid password" do
      user.save
      found_user = User.find_by_email(user.email)
      expect(user).not_to eq(found_user.authenticate('invalid'))
    end
  end

end