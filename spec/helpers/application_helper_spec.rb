require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should return correct title" do
      full_title("foo").should == 'Expense Report | foo'
    end
    
    it "should not include a bar if page title is empty" do
      full_title("").should == 'Expense Report'
    end
  end
end