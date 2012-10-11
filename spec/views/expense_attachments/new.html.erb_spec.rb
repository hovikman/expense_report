require 'spec_helper'

describe "expense_attachments/new" do
  before(:each) do
    assign(:expense_attachment, stub_model(ExpenseAttachment,
      :expense_id => "",
      :description => "MyString",
      :file_path => "MyString"
    ).as_new_record)
  end

  it "renders new expense_attachment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => expense_attachments_path, :method => "post" do
      assert_select "input#expense_attachment_expense_id", :name => "expense_attachment[expense_id]"
      assert_select "input#expense_attachment_description", :name => "expense_attachment[description]"
      assert_select "input#expense_attachment_file_path", :name => "expense_attachment[file_path]"
    end
  end
end
