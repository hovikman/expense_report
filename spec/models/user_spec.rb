require 'spec_helper'

describe User do

  context "attributes" do
    let(:user) { FactoryGirl.build(:user) }
    [:authenticate, :company_id, :email, :id, :manager_id, :name,
     :password, :password_confirmation, :password_digest, :password_reset_sent_at,
     :password_reset_token, :phone, :remember_token, :user_type_id].each do |attr|
      it "responds to #{attr}" do
        user.should respond_to(attr)
      end
    end
  end

  context "scope" do
    it "responds to #for_datatable" do
      User.should respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        FactoryGirl.create(:user)
        @user = User.for_datatable.first
      end
      [:id, :name, :company_name, :user_type_name].each do |attr|
        it "responds to #{attr}" do
          @user.should respond_to(attr)
        end
      end
    end
  end

  context "associations" do
    let(:user) { FactoryGirl.create(:user) }
    [:users, :expenses, :owned_expenses, :company, :manager, :user_type].each do |assoc|
      it "responds to #{assoc}" do
        user.should respond_to(assoc)
      end
    end
    it "retrieves users" do
      employee = FactoryGirl.create(:user, manager_id: user.id)
      user.users.should == [employee]
    end
    it "retrieves expenses" do
      expense = FactoryGirl.create(:expense, user: user)
      user.expenses.should == [expense]
    end
    it "retrieves owned_expenses" do
      expense = FactoryGirl.create(:expense, user: user, owner: user)
      user.owned_expenses.should == [expense]
    end
    it "retrieves company" do
      company = FactoryGirl.create(:company)
      user.company_id = company.id
      user.company.should == company
    end
    it "retrieves manager" do
      manager = FactoryGirl.create(:user)
      user.manager_id = manager.id
      user.manager.should == manager
    end
    it "retrieves user_type" do
      user_type = FactoryGirl.create(:user_type)
      user.user_type_id = user_type.id
      user.user_type.should == user_type
    end
  end
  
  context "validations" do
    let(:user) { FactoryGirl.build(:user) }
    [:company_id, :name, :email, :user_type_id].each do |attr|
      it "requires #{attr}" do
        user[attr] = nil
        user.should_not be_valid
        user.errors[attr].should_not be_nil
      end
    end
    it "rejects names that are too long" do
      user.name = "a" * 31
      user.should_not be_valid
      user.errors[:company_id].should_not be_nil
    end
    it "rejects identical emails" do
      user.save
      user_new = FactoryGirl.build(:user)
      user_new.email = user.email.upcase
      user_new.should_not be_valid
      user_new.errors[:email].should_not be_nil
    end
    it "rejects emails that are too long" do
      user.email = "a" * 41
      user.should_not be_valid
      user.errors[:email].should_not be_nil
    end
    it "rejects invalid emails" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |email|
        user.email = email
        user.should_not be_valid
        user.errors[:email].should_not be_nil
      end      
    end
    it "accepts valid emails" do
      emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |email|
        user.email = email
        user.should be_valid
        user.should have(:no).error_on(:email)
      end
    end      
    it "rejects phones that are too long" do
      user.phone = "a" * 21
      user.should_not be_valid
      user.errors[:phone].should_not be_nil
    end
    it "rejects duplicate names in the same company scope" do
      new_user = FactoryGirl.create(:user, company: user.company)
      user.name = new_user.name
      user.should_not be_valid
      user.errors[:name].should_not be_nil
    end
    it "appcepts duplicate names in different company scopes" do
      company = FactoryGirl.create(:company)
      new_user = FactoryGirl.create(:regular_user, company: company)
      user.name = new_user.name
      user.should be_valid
      user.errors[:name].should_not be_nil
    end
    it "reject vendor admins for companies other than 'vendor'" do
      company = FactoryGirl.create(:company)
      vendor_admin = FactoryGirl.build(:vendor_admin, company: company)
      vendor_admin.should_not be_valid
      vendor_admin.errors[:user_type_id].should_not be_nil
    end
  end

  it "after_initialize" do
    pending "need more time to understand how to do it"
  end

  context "callbacks" do
    let(:user) { FactoryGirl.build(:user) }
    it "calls downcase on 'email' field before save" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user.email = mixed_case_email
      user.save
      user.reload.email.should == mixed_case_email.downcase
    end
    it "generates remember_token" do
      user.save
      user.remember_token.should_not be_blank
    end
    it "tests related to before_destroy :ensure_not_referenced_by_any_user" do
      pending "need more time to understand how to do it"
    end
    it "tests related to before_destroy :ensure_not_referenced_by_any_expense" do
      pending "need more time to understand how to do it"
    end
    it "tests related to before_destroy :ensure_not_accountant" do
      pending "need more time to understand how to do it"
    end
  end

  context "methods" do
    describe "respond" do
      let(:user) { FactoryGirl.build(:user) }
      [:vendor_admin?, :regular_user?, :company_admin?, :admin?, :guest?,
       :password_valid?, :manager_name, :name_with_company, :send_password_reset].each do |method|
        it "responds to #{method}" do
          user.should respond_to(method)
        end
      end
    end
    describe "regular user" do
      let(:regular_user) { FactoryGirl.build(:regular_user) }
      it "is not vendor admin" do
        regular_user.vendor_admin?.should == false
      end
      it "is regular user" do
        regular_user.regular_user?.should == true
      end
      it "is not company admin" do
        regular_user.company_admin?.should == false
      end
      it "is not admin" do
        regular_user.admin?.should == false
      end
      it "is not guest" do
        regular_user.guest?.should == false
      end
    end
    describe "company admin" do
      let(:company_admin) { FactoryGirl.build(:company_admin) }
      it "is not vendor admin" do
        company_admin.vendor_admin?.should == false
      end
      it "is not regular user" do
        company_admin.regular_user?.should == false
      end
      it "is company admin" do
        company_admin.company_admin?.should == true
      end
      it "is admin" do
        company_admin.admin?.should == true
      end
      it "is not guest" do
        company_admin.guest?.should == false
      end
    end
    describe "vendor admin" do
      let(:vendor_admin) { FactoryGirl.build(:vendor_admin) }
      it "is vendor admin" do
        vendor_admin.vendor_admin?.should == true
      end
      it "is not regular user" do
        vendor_admin.regular_user?.should == false
      end
      it "is not company admin" do
        vendor_admin.company_admin?.should == false
      end
      it "is admin" do
        vendor_admin.admin?.should == true
      end
      it "is not guest" do
        vendor_admin.guest?.should == false
      end
    end
    describe "guest" do
      let(:guest) { User.new }
      it "is not vendor admin" do
        guest.vendor_admin?.should == false
      end
      it "is not regular user" do
        guest.regular_user?.should == false
      end
      it "is not company admin" do
        guest.company_admin?.should == false
      end
      it "is not admin" do
        guest.admin?.should == false
      end
      it "is guest" do
        guest.guest?.should == true
      end
    end
    describe "manager_name" do
      let(:user) { FactoryGirl.build(:user) }
      it "manager_name returns empty string when user dosn't have manager" do
        user.manager_name.should be_blank
      end
      it "manager_name returns correct value when user has a manager" do
        manager = FactoryGirl.create(:user)
        user.manager_id = manager.id
        user.manager_name.should == manager.name
      end
    end
    describe "name_with_company" do
      let(:user) { FactoryGirl.build(:user) }
      it "name_with_company returns correct value" do
        manager = FactoryGirl.create(:user)
        user.name_with_company.should == "#{user.name}, #{user.company.name}"
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
      user.should_not be_valid
    end
    it "rejects passwords that are too short" do
      user.password = user.password_confirmation = "a" * 5
      user.password_valid?(user.password).should be false
    end
    it "authenticates user with correct password" do
      user.save
      found_user = User.find_by_email(user.email)
      user.should == found_user.authenticate(user.password)
    end
    it "doesn't authenticate user with invalid password" do
      user.save
      found_user = User.find_by_email(user.email)
      user.should_not == found_user.authenticate('invalid')
    end
  end

end