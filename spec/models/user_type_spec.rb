require 'spec_helper'

describe UserType do

  before(:each) do
    @attr = {
      name: "Example UserType"
    }
  end
  
  describe "attributes" do
    it "should create a new instance given a valid attribute" do
      UserType.create!(@attr)
    end
    it "should respond to #name" do
      user_type = UserType.create!(@attr)
      user_type.should respond_to(:name)
    end
  end
    
  describe "scope and number of rows" do
    user_types = UserType.all
    it "number of UserTypes should be 3" do 
      user_types.count.should == 3
    end
    it "first element should be 'Administrator'" do 
      user_types[0].name.should == "Administrator"
    end
    it "second element should be 'Regular User'" do
      user_types[1].name.should == "Regular User"
    end
    it "third element should be 'Vendor Administrator'" do
      user_types[2].name.should == "Vendor Administrator"
    end
  end

  describe "associations" do
    user_type = UserType.first
    it { user_type.should respond_to :users }
    it "tests related to User association" do
      pending "need more time to understand how to do it"
    end
  end
    
  describe "validations" do
    it "should require a name" do
      no_name_user_type = UserType.new(@attr.merge(name: ""))
      no_name_user_type.should_not be_valid
    end
  
    it "should reject names that are too long" do
      long_name = "a" * 21
      long_name_user_type = UserType.new(@attr.merge(name: long_name))
      long_name_user_type.should_not be_valid
    end

    it "should reject duplicate names" do
      UserType.create!(@attr)
      usertype_with_duplicate_name = UserType.new(@attr)
      usertype_with_duplicate_name.should_not be_valid
    end
  end

  describe "callbacks" do
    before(:each) do
      @vendor_admin = UserType.find(UserType.vendor_admin_id)
    end
    it "should raise error when 'vendor administrator' UserType is deleted" do
      lambda do
        @vendor_admin.destroy
      end.should raise_error(RuntimeError)
    end
    it "number of records in UserType table should not be changed when attempted to delete 'vendor administrator' UserType" do
      lambda do
        begin
          @vendor_admin.destroy
        rescue RuntimeError
        end
      end.should_not change(UserType, :count)
    end
    it "callback #ensure_not_referenced_by_any_user should be called when attempted to delete 'vendor administrator' UserType" do
      @vendor_admin.should_receive(:ensure_not_referenced_by_any_user)      
      begin
        @vendor_admin.destroy
      rescue RuntimeError
      end
    end
  end
      
  describe "methods" do
    describe "responds" do
      subject { UserType }
      it { should respond_to :admin_id }
      it { should respond_to :regular_user_id }
      it { should respond_to :vendor_admin_id }
    end
    describe "return types" do
      it "#admin_id should return number" do
        UserType.admin_id.should be_a_kind_of(Fixnum)
      end
      it "#regular_user_id should return number" do
        UserType.regular_user_id.should be_a_kind_of(Fixnum)
      end
      it "#vendor_admin_id should return number" do
        UserType.vendor_admin_id.should be_a_kind_of(Fixnum)
      end
    end
  end
  
end