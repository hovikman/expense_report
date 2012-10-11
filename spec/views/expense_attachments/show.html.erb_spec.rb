require 'spec_helper'

describe "expense_attachments/show" do
  before(:each) do
    @expense_attachment = assign(:expense_attachment, stub_model(ExpenseAttachment,
      :expense_id => "",
      :description => "Description",
      :file_path => "File Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Description/)
    rendered.should match(/File Path/)
  end
end
