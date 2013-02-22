require 'spec_helper'

describe 'factories' do
  [:company, :currency, :expense, :expense_with_attachments,
   :expense_with_details, :expense_with_details_and_attachments,
   :expense_attachment, :expense_detail, :expense_status, :expense_type,
   :user, :vendor_admin, :regular_user, :company_admin, :user_type].each do |factory|
    it "instance of #{factory} is valid" do
      FactoryGirl.create(factory).should be_valid
    end
  end
end