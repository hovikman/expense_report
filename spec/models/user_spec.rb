require 'spec_helper'

describe User do

  before { @user = User.new(company_id: 1,
                            name: "Example User",
                            email: "user@example.com",
                            user_type_id: 1) }

  subject { @user }

  # test accessable attributes
  it { should respond_to(:company_id) }
  it { should respond_to(:email) }
  it { should respond_to(:id) }
  it { should respond_to(:manager_id) }
  it { should respond_to(:name) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_reset_sent_at) }
  it { should respond_to(:password_reset_token) }
  it { should respond_to(:phone) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:user_type_id) }

  # test validity  
  it { should be_valid }
  
  # test presence
  describe "when company_id is not present" do
    before { @user.company_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when user_type_id is not present" do
    before { @user.user_type_id = nil }
    it { should_not be_valid }
  end

  # test length
  describe "when name is too long" do
    before { @user.name = "a" * 31 }
    it { should_not be_valid }
  end

  describe "when email is too long" do
    before { @user.email = "a" * 41 }
    it { should_not be_valid }
  end

  describe "when phone is too long" do
    before { @user.phone = "a" * 21 }
    it { should_not be_valid }
  end

  # test format
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end
  
  # test uniqueness
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

end