require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should return correct title" do
      expect(full_title("foo")).to eq('Expense Report | foo')
    end
    
    it "should not include a bar if page title is empty" do
      expect(full_title("")).to eq('Expense Report')
    end
  end
  
end