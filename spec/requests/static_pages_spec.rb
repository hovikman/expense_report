require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "should have the content 'Expense Report Application'" do
      visit root_path
      page.should have_selector('h1', text: "Expense Report Application")
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
      page.should have_selector('h1', text: "Help")
    end
  end

  describe "About page" do
    it "should have the content 'About'" do
      visit about_path
      page.should have_selector('h1', text: "About")
    end
  end

  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: "Contact")
    end
  end

end
