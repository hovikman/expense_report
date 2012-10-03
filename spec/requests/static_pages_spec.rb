require 'spec_helper'

describe "StaticPages" do

  let(:base_title) { "Expense Report" }
  
  describe "Home page" do
    it "should have the h1 'Expense Report Application'" do
      visit root_path
      page.should have_selector('h1', text: "Expense Report Application")
    end
    
    it "should have the title 'Home'" do
      visit root_path
      page.should have_selector('title', text: "#{base_title} | Home")
    end
  end

  describe "Help page" do
    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1', text: "Help")
    end
    
    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title', text: "#{base_title} | Help")
    end
  end

  describe "About page" do
    it "should have the h1 'About'" do
      visit about_path
      page.should have_selector('h1', text: "About")
    end
    
    it "should have the title 'About'" do
      visit about_path
      page.should have_selector('title', text: "#{base_title} | About")
    end
  end

  describe "Contact page" do
    it "should have the h1 'Contact'" do
      visit contact_path
      page.should have_selector('h1', text: "Contact")
    end
    
    it "should have the title 'Contact'" do
      visit contact_path
      page.should have_selector('title', text: "#{base_title} | Contact")
    end
  end

end