require 'spec_helper'

feature 'Static Pages' do
  before(:each) do
    visit root_path
  end  
  
  describe 'About page' do
    before (:each) do
      click_link 'About'
    end
    it_should_behave_like 'all static pages', 'About', 'About'
  end
  
  describe 'Contact page' do
    before (:each) do
      click_link 'Contact'
    end
    it_should_behave_like 'all static pages', 'Contact', 'Contact'
  end

  describe 'Home page' do
    before (:each) do
      click_link 'Home'
    end
    it_should_behave_like 'all static pages', 'Expense Report Application', 'Home'
  end

  describe 'Help page' do
    before (:each) do
      click_link 'Help'
    end
    it_should_behave_like 'all static pages', 'Help', 'Help'
  end

  describe 'Sign in page' do
    before (:each) do
      click_link 'Sign in'
    end
    it_should_behave_like 'all static pages', 'Sign in', 'Sign in'
  end

  describe 'Sign out page' do
    before (:each) do
      login_in(create(:user))
      click_link 'Sign out'
   end
    it_should_behave_like 'all static pages', 'Expense Report Application', 'Home'
  end

end