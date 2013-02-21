require 'spec_helper'

describe UserType do

  describe "attributes" do
    let(:user_type) { FactoryGirl.build(:user_type) }
    it "responds to #name" do
      user_type.should respond_to(:name)
    end
  end
    
  describe "scope and number of rows" do
    let(:user_types) { UserType.all }
    it "number of UserTypes is 3" do 
      user_types.count.should == 3
    end
    it "first element is 'Administrator'" do 
      user_types[0].name.should == "Administrator"
    end
    it "second element is 'Regular User'" do
      user_types[1].name.should == "Regular User"
    end
    it "third element is 'Vendor Administrator'" do
      user_types[2].name.should == "Vendor Administrator"
    end
  end

  describe "associations" do
    let(:user_type) { FactoryGirl.build(:user_type) }
    it "responds to #users" do
      user_type.should respond_to :users
    end
    it "tests related to User association" do
      pending "need more time to understand how to do it"
    end
  end
    
  describe "validations" do
    let(:user_type) { FactoryGirl.build(:user_type) }
    it "requires name" do
      user_type.name = ''
      user_type.should_not be_valid
      user_type.errors[:name].should_not be_nil
    end
    it "rejects names that are too long" do
      user_type.name = "a" * 21
      user_type.should_not be_valid
      user_type.errors[:name].should_not be_nil
    end
    it "rejects duplicate names" do
      new_user_type = FactoryGirl.create(:user_type)
      user_type.name = new_user_type.name
      user_type.should_not be_valid
      user_type.errors[:name].should_not be_nil
    end
  end

  describe "callbacks" do
    let(:vendor_admin) { UserType.find(UserType.vendor_admin_id) }
    it "raises error when 'vendor administrator' UserType is deleted" do
      expect {
        vendor_admin.destroy
      }.to raise_error(
        RuntimeError,
        "Cannot delete user type 'Vendor Administrator'. There are users referencing this user type."
        )
    end
    it "number of records in UserType table is not changed when attempted to delete 'vendor administrator' UserType" do
      expect {
        begin
          vendor_admin.destroy
        rescue RuntimeError
        end
      }.to_not change(UserType, :count)
    end
    it "callback #ensure_not_referenced_by_any_user is called when attempted to delete 'vendor administrator' UserType" do
      vendor_admin.should_receive(:ensure_not_referenced_by_any_user)      
      begin
        vendor_admin.destroy
      rescue RuntimeError
      end
    end
  end
      
  describe "methods" do
    it "responds to #admin_id" do
      UserType.should respond_to :admin_id
    end
    it "responds to #regular_user_id" do
      UserType.should respond_to :regular_user_id
    end
    it "responds to #vendor_admin_id" do
      UserType.should respond_to :vendor_admin_id
    end
    it "#admin_id returns number" do
      UserType.admin_id.should be_a_kind_of(Fixnum)
    end
    it "#regular_user_id returns number" do
      UserType.regular_user_id.should be_a_kind_of(Fixnum)
    end
    it "#vendor_admin_id returns number" do
      UserType.vendor_admin_id.should be_a_kind_of(Fixnum)
    end
  end
  
end