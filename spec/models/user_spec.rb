require 'spec_helper'

describe User do

  describe "attributes" do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end
    it "responds to #authenticate" do
      @user.should respond_to(:authenticate)
    end
    it "responds to #company_id" do
      @user.should respond_to(:company_id)
    end
    it "responds to #email" do
      @user.should respond_to(:email)
    end
    it "responds to #id" do
      @user.should respond_to(:id)
    end
    it "responds to #manager_id" do
      @user.should respond_to(:manager_id)
    end
    it "responds to #name" do
      @user.should respond_to(:name)
    end
    it "responds to #password" do
      @user.should respond_to(:password)
    end
    it "responds to #password_confirmation" do
      @user.should respond_to(:password_confirmation)
    end
    it "responds to #password_digest" do
      @user.should respond_to(:password_digest)
    end
    it "responds to #password_reset_sent_at" do
      @user.should respond_to(:password_reset_sent_at)
    end
    it "responds to #password_reset_token" do
      @user.should respond_to(:password_reset_token)
    end
    it "responds to #phone" do
      @user.should respond_to(:phone)
    end
    it "responds to #remember_token" do
      @user.should respond_to(:remember_token)
    end
    it "responds to #user_type_id" do
      @user.should respond_to(:user_type_id)
    end
  end

  describe "scope" do
    it "responds to #for_datatable" do
      User.should respond_to(:for_datatable)
    end
    describe "elements of for_datatable scope" do
      before(:each) do
        FactoryGirl.create(:user)
        @user = User.for_datatable.first
      end
      it "responds to #id" do
        @user.should respond_to(:id)
      end
      it "responds to #name" do
        @user.should respond_to(:name)
      end
      it "responds to #company_name" do
        @user.should respond_to(:company_name)
      end
      it "responds to #company_name" do
        @user.should respond_to(:company_name)
      end
    end
  end

  describe "associations" do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end
    it "responds to #users" do
      @user.should respond_to :users
    end
    it "responds to #expenses" do
      @user.should respond_to :expenses
    end
    it "responds to #owned_expenses" do
      @user.should respond_to :owned_expenses
    end
    it "responds to #company" do
      @user.should respond_to :company
    end
    it "responds to #manager" do
      @user.should respond_to :manager
    end
    it "responds to #user_type" do
      @user.should respond_to :user_type
    end
    it "tests related to 'users' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'expenses' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'owned_expenses' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'company' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'manager' association" do
      pending "need more time to understand how to do it"
    end
    it "tests related to 'user_type' association" do
      pending "need more time to understand how to do it"
    end
  end
  
  describe "validations" do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end
    it "requires company_id" do
      @user.company_id = nil
      @user.should_not be_valid
      @user.should have(1).error_on(:company_id)
    end
    it "requires name" do
      @user.name = ''
      @user.should_not be_valid
      @user.should have(1).error_on(:name)
    end
    it "rejects names that are too long" do
      @user.name = "a" * 31
      @user.should_not be_valid
      @user.should have(1).error_on(:name)
    end
    it "requires email" do
      @user.email = ''
      @user.should_not be_valid
      @user.should have_at_least(1).error_on(:email)
    end
    it "rejects identical emails" do
      @user.save
      user = FactoryGirl.build(:user)
      user.email = @user.email.upcase
      user.should_not be_valid
      user.should have(1).error_on(:email)
    end
    it "rejects emails that are too long" do
      @user.email = "a" * 41
      @user.should_not be_valid
      @user.should have_at_least(1).error_on(:email)
    end
    it "rejects invalid emails" do
      emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      emails.each do |email|
        @user.email = email
        @user.should_not be_valid
        @user.should have(1).error_on(:email)
      end      
    end
    it "accepts valid emails" do
      emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      emails.each do |email|
        @user.email = email
        @user.should be_valid
        @user.should have(:no).error_on(:email)
      end
    end      
    it "rejects phones that are too long" do
      @user.phone = "a" * 21
      @user.should_not be_valid
      @user.should have(1).error_on(:phone)
    end
    it "requires user_type_id" do
      @user.user_type_id = nil
      @user.should_not be_valid
      @user.should have(1).error_on(:user_type_id)
    end
    it "rejects duplicate names in the same company scope" do
      user = FactoryGirl.create(:user)
      @user.name = user.name
      @user.should_not be_valid
      @user.should have(1).error_on(:name)
    end
    it "appcepts duplicate names in different company scopes" do
      company = FactoryGirl.create(:company)
      user = FactoryGirl.create(:regular_user, company: company)
      @user.name = user.name
      @user.should be_valid
      @user.should have(:no).error_on(:name)
    end
    it "reject vendor admins for companies other than 'vendor'" do
      company = FactoryGirl.create(:company)
      vendor_admin = FactoryGirl.build(:vendor_admin, company: company)
      vendor_admin.should_not be_valid
      vendor_admin.should have(1).error_on(:user_type_id)
    end
  end

  it "after_initialize" do
    pending "need more time to understand how to do it"
  end

  describe "callbacks" do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end
    it "calls downcase on 'email' field before save" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
    it "generates remember_token" do
      @user.save
      @user.remember_token.should_not be_blank
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

  describe "methods" do
    describe "respond" do
      before(:each) do
        @user = FactoryGirl.build(:user)
      end
      it "responds to #vendor_admin?" do
        @user.should respond_to :vendor_admin?
      end
      it "responds to #regular_user?" do
        @user.should respond_to :regular_user?
      end
      it "responds to #company_admin?" do
        @user.should respond_to :company_admin?
      end
      it "responds to #admin?" do
        @user.should respond_to :admin?
      end
      it "responds to #guest?" do
        @user.should respond_to :guest?
      end
      it "responds to #password_valid?" do
        @user.should respond_to :password_valid?
      end
      it "responds to #manager_name" do
        @user.should respond_to :manager_name
      end
      it "responds to #name_with_company" do
        @user.should respond_to :name_with_company
      end
      it "responds to #send_password_reset" do
        @user.should respond_to :send_password_reset
      end
    end
    describe "regular user" do
      before(:each) do
        @regular_user = FactoryGirl.build(:regular_user)
      end
      it "is not vendor admin" do
        @regular_user.vendor_admin?.should == false
      end
      it "is regular user" do
        @regular_user.regular_user?.should == true
      end
      it "is not company admin" do
        @regular_user.company_admin?.should == false
      end
      it "is not admin" do
        @regular_user.admin?.should == false
      end
      it "is not guest" do
        @regular_user.guest?.should == false
      end
    end
    describe "company admin" do
      before(:each) do
        @company_admin = FactoryGirl.build(:company_admin)
      end
      it "is not vendor admin" do
        @company_admin.vendor_admin?.should == false
      end
      it "is not regular user" do
        @company_admin.regular_user?.should == false
      end
      it "is company admin" do
        @company_admin.company_admin?.should == true
      end
      it "is admin" do
        @company_admin.admin?.should == true
      end
      it "is not guest" do
        @company_admin.guest?.should == false
      end
    end
    describe "vendor admin" do
      before(:each) do
        @vendor_admin = FactoryGirl.build(:vendor_admin)
      end
      it "is vendor admin" do
        @vendor_admin.vendor_admin?.should == true
      end
      it "is not regular user" do
        @vendor_admin.regular_user?.should == false
      end
      it "is not company admin" do
        @vendor_admin.company_admin?.should == false
      end
      it "is admin" do
        @vendor_admin.admin?.should == true
      end
      it "is not guest" do
        @vendor_admin.guest?.should == false
      end
    end
    describe "guest" do
      before(:each) do
        @guest = User.new
      end
      it "is not vendor admin" do
        @guest.vendor_admin?.should == false
      end
      it "is not regular user" do
        @guest.regular_user?.should == false
      end
      it "is not company admin" do
        @guest.company_admin?.should == false
      end
      it "is not admin" do
        @guest.admin?.should == false
      end
      it "is guest" do
        @guest.guest?.should == true
      end
    end
    describe "manager_name" do
      before(:each) do
        @user = FactoryGirl.build(:user)
      end
      it "manager_name returns empty string when user dosn't have manager" do
        @user.manager_name.should be_blank
      end
      it "manager_name returns correct value when user has a manager" do
        manager = FactoryGirl.create(:user)
        @user.manager_id = manager.id
        @user.manager_name.should == manager.name
      end
    end
    describe "name_with_company" do
      before(:each) do
        @user = FactoryGirl.build(:user)
      end
      it "name_with_company returns correct value" do
        manager = FactoryGirl.create(:user)
        @user.name_with_company.should == "#{@user.name}, #{@user.company.name}"
      end
    end
    describe "send_password_reset" do
      pending "need more time to understand how to do it"
    end
  end
  
  describe "authentication" do
    before(:each) do
      @user = FactoryGirl.build(:user)
    end
    it "rejects when password and password_confirmation do not match" do
      @user.password_confirmation = "mismatch"
      @user.should_not be_valid
    end
    it "rejects passwords that are too short" do
      @user.password = @user.password_confirmation = "a" * 5
      @user.password_valid?(@user.password).should be false
    end
    it "authenticates user with correct password" do
      @user.save
      found_user = User.find_by_email(@user.email)
      @user.should == found_user.authenticate(@user.password)
    end
    it "doesn't authenticate user with invalid password" do
      @user.save
      found_user = User.find_by_email(@user.email)
      @user.should_not == found_user.authenticate('invalid')
    end
  end

end