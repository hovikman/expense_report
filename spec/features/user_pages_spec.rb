require 'spec_helper'

feature "User pages" do

  describe "New User Page" do
    describe "Heading and Title" do
      before do
        login_in(create(:vendor_admin))
        visit new_user_path
      end
      it_should_behave_like "all static pages", 'New User', 'New User'
    end 
    describe "with invalid information" do
      before do
        login_in(create(:vendor_admin))
        visit new_user_path
      end
      it "should not create a user" do
        expect { click_button "Create User" }.not_to change(User, :count)
      end
    end
    describe "with valid information" do
      before do
        login_in(create(:vendor_admin))
        visit new_user_path
      end
      it "should create a user" do
        select  "Vendor",       from: "Company"
        fill_in "Name",         with: "Test User2"
        fill_in "Email",        with: "user@example.com"
        select  "Regular User", with: "User Type"
        expect { click_button "Create User" }.to change(User, :count).by(1)
      end
    end
  end
  
  describe "Viewing User Page" do
    before do
      user = create(:user)
      login_in(user)
      visit user_path(user)
    end
    it_should_behave_like "all static pages", 'Viewing User', 'Viewing User'
  end
  
end