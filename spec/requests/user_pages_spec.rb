require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "New User Page" do

    before { visit new_user_path }

    describe "Heading and Titel" do
      before { visit signin_path }
      let(:user) { FactoryGirl.create(:vendor_admin) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      before { visit new_user_path }   
      let(:heading)    { 'New User' }
      let(:page_title) { 'New User' }
      it_should_behave_like "all static pages"
    end 

    let(:submit) { "Create User" }

    describe "with invalid information" do
      before { visit signin_path }
      let(:user) { FactoryGirl.create(:vendor_admin) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      it "should not create a user" do
        before { visit new_user_path }
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before { visit signin_path }
      let(:user) { FactoryGirl.create(:vendor_admin) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      
      before do
        visit new_user_path
        select  "Vendor",       from: "Company"
        fill_in "Name",         with: "Test User2"
        fill_in "Email",        with: "user@example.com"
        select  "Regular User", with: "User Type"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  
  describe "Viewing User Page" do
    before { visit signin_path }
    let(:user) { FactoryGirl.create(:user) }
    before do
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    before { visit user_path(user) }
    let(:heading)    { 'Viewing User' }
    let(:page_title) { 'Viewing User' }
    it_should_behave_like "all static pages"
  end
  
  # describe "Sign in/Sign out links" do
    # before { visit root_path }
    # it { should have_link('Sign in') }
    # it { should_not have_link('Sign out') }
#   
    # before { visit signin_path }
    # let(:user) { FactoryGirl.create(:user) }
    # before do
      # fill_in "Email",    with: user.email
      # fill_in "Password", with: user.password
      # click_button "Sign in"
    # end
    # let(:heading)    { 'Expense Report Application' }
    # let(:page_title) { 'Home' }
    # it_should_behave_like "all static pages"
# 
    # it { should_not have_link('Sign in') }
    # it { should have_link('Sign out') }
    # it { should have_link('Admin') }
#   
    # before { click_link "Sign out" }
    # it { should have_link('Sign in') }
    # it { should_not have_link('Sign out') }
  # end

end