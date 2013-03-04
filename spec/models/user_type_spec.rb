require 'spec_helper'

describe UserType do

  context "attributes" do
    let(:user_type) { build(:user_type) }
    it "responds to #name" do
      expect(user_type).to respond_to(:name)
    end
  end
    
  context "scope and number of rows" do
    let(:user_types) { UserType.all }
    it "number of UserTypes is 3" do 
      expect(user_types.count).to eq(3)
    end
    it "first element is 'Administrator'" do 
      expect(user_types[0].name).to eq("Administrator")
    end
    it "second element is 'Regular User'" do
      expect(user_types[1].name).to eq("Regular User")
    end
    it "third element is 'Vendor Administrator'" do
      expect(user_types[2].name).to eq("Vendor Administrator")
    end
  end

  context "associations" do
    let(:user_type) { create(:user_type) }
    it "responds to #users" do
      expect(user_type).to respond_to(:users)
    end
    it "retrieves users" do
      user = create(:user, user_type: user_type)
      expect(user_type.users).to eq([user])
    end
  end
    
  context "validations" do
    let(:user_type) { build(:user_type) }
    it "requires name" do
      user_type.name = ''
      expect(user_type.errors[:name]).not_to be_nil
    end
    it "rejects names that are too long" do
      user_type.name = "a" * 21
      expect(user_type.errors[:name]).not_to be_nil
    end
    it "rejects duplicate names" do
      new_user_type = create(:user_type)
      user_type.name = new_user_type.name
      expect(user_type.errors[:name]).not_to be_nil
    end
  end

  context "callbacks" do
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
      
  context "methods" do
    [:admin_id, :regular_user_id, :vendor_admin_id].each do |method|
      it "responds to #{method}" do
        expect(UserType).to respond_to(method)
      end
      it "#{method} returns number" do
        expect(UserType.send(method)).to be_a_kind_of(Fixnum)
      end
    end
  end
  
end