require 'spec_helper'

describe 'factories' do
  it "instance of 'company' is valid" do
    FactoryGirl.create(:company).should be_valid
  end
  it "instance of 'currency' is valid" do
    FactoryGirl.create(:currency).should be_valid
  end
  it "instance of 'expense' is valid" do
    FactoryGirl.create(:expense).should be_valid
  end
  it "instance of 'expense_with_attachments' is valid" do
    FactoryGirl.create(:expense_with_attachments).should be_valid
  end
  it "instance of 'expense_with_details' is valid" do
    FactoryGirl.create(:expense_with_details).should be_valid
  end
  it "instance of 'expense_with_details_and_attachments' is valid" do
    FactoryGirl.create(:expense_with_details_and_attachments).should be_valid
  end
  it "instance of 'expense_attachment' is valid" do
    FactoryGirl.create(:expense_attachment).should be_valid
  end
  it "instance of 'expense_detail' is valid" do
    FactoryGirl.create(:expense_detail).should be_valid
  end
  it "instance of 'expense_status' is valid" do
    FactoryGirl.create(:expense_status).should be_valid
  end
  it "instance of 'expense_type' is valid" do
    FactoryGirl.create(:expense_type).should be_valid
  end
  it "instance of 'user' is valid" do
    FactoryGirl.create(:user).should be_valid
  end
  it "instance of 'vendor_admin' is valid" do
    FactoryGirl.create(:vendor_admin).should be_valid
  end
  it "instance of 'regular_user' is valid" do
    FactoryGirl.create(:regular_user).should be_valid
  end
  it "instance of 'company_admin' is valid" do
    FactoryGirl.create(:company_admin).should be_valid
  end
  it "instance of 'user_type' is valid" do
    FactoryGirl.create(:user_type).should be_valid
  end
end