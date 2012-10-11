require 'spec_helper'

describe "expense_attachments/index" do
  before(:each) do
    assign(:expense_attachments, [
      stub_model(ExpenseAttachment,
        :expense_id => "",
        :description => "Description",
        :file_path => "File Path"
      ),
      stub_model(ExpenseAttachment,
        :expense_id => "",
        :description => "Description",
        :file_path => "File Path"
      )
    ])
  end

  it "renders a list of expense_attachments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "File Path".to_s, :count => 2
  end
end
