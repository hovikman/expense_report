require 'spec_helper'

describe "Static Pages" do
  
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Expense Report Application' }
    let(:page_title) { 'Home' }
    
    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }
    
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About' }
    let(:page_title) { 'About' }
    
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)    { 'Contact' }
    let(:page_title) { 'Contact' }
    
    it_should_behave_like "all static pages"
  end
  
  describe "Sign in page" do
    before { visit signin_path }
    let(:heading)    { 'Sign in' }
    let(:page_title) { 'Sign in' }
    
    it_should_behave_like "all static pages"
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Home"
    page.should have_selector 'title', text: full_title('Home')
    click_link "Sign in"
    page.should have_selector 'title', text: full_title('Sign in')
  end

end