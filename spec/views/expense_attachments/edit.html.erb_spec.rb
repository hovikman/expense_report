require 'spec_helper'

describe "expense_attachments/edit" do
  before(:each) do
    @expense_attachment = assign(:expense_attachment, stub_model(ExpenseAttachment,
      :expense_id => "",
      :description => "MyString",
      :file_path => "MyString"
    ))
  end

  it "renders the edit expense_attachment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => expense_attachments_path(@expense_attachment), :method => "post" do
      assert_select "input#expense_attachment_expense_id", :name => "expense_attachment[expense_id]"
      assert_select "input#expense_attachment_description", :name => "expense_attachment[description]"
      assert_select "input#expense_attachment_file_path", :name => "expense_attachment[file_path]"
    end
  end
end
