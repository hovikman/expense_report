require 'spec_helper'

feature "Authentication" do

  describe "sign in with invalid information" do
    before (:each) do
      visit signin_path
      click_button "Sign in"
    end
    describe "has correct error message" do
      it { expect(page).to have_selector('div.alert.alert-error', text: 'Invalid email/password combination') }
    end
    describe "no error message after visiting another page" do
      before (:each) do
        click_link "Home"
      end
      it { expect(page).not_to have_selector('div.alert.alert-error') }
    end
  end
  
  describe "vendor_admin" do
    before (:each) do
      @user = create(:vendor_admin)
      login_in(@user)
    end
    it { expect(page).to have_link('Home', href: root_path) }
    it { expect(page).not_to have_link('Sign in')}
    it { expect(page).to have_link('Account', href: '#') }
      it { expect(page).to have_link('Profile', href: edit_user_path(@user.id)) }
      it { expect(page).to have_link('Settings', href: '#') }
      it { expect(page).to have_link('Sign out', href: signout_path) }
    it { expect(page).to have_link('Admin', href: '#') }
      it { expect(page).to have_link('Resources', href: '#') }
        it { expect(page).to have_link('Companies', href: companies_path) }
        it { expect(page).to have_link('Currencies', href: currencies_path) }
        it { expect(page).to have_link('Expenses', href: expenses_path) }
        it { expect(page).to have_link('Expense Statuses', href: expense_statuses_path) }
        it { expect(page).to have_link('Expense Types', href: expense_types_path) }
        it { expect(page).to have_link('Users', href: users_path) }
        it { expect(page).to have_link('User Types', href: user_types_path) }
      it { expect(page).to have_link('Utilities', href: '#') }
        it { expect(page).to have_link('Replace Expense Owner', href: new_replace_expense_owner_path) }
        it { expect(page).to have_link('Replace User Manager', href: new_replace_user_manager_path) }
      it { expect(page).to have_link('Delayed Jobs', href: delayed_job_url) }
    it { expect(page).to have_link('Expenses', href: '#') }
      it { expect(page).to have_link('New Expense', href: new_expense_path) }
      it { expect(page).to have_link('Submitted Expenses', href: submitted_expenses_path) }
      it { expect(page).to have_link('Owned Expense', href: owned_expenses_path) }
    it { expect(page).to have_link('Help', href: help_path) }
  end

  describe "company_admin" do
    before (:each) do
      @user = create(:company_admin)
      login_in(@user)
    end
    it { expect(page).to have_link('Home', href: root_path) }
    it { expect(page).not_to have_link('Sign in')}
    it { expect(page).to have_link('Account', href: '#') }
      it { expect(page).to have_link('Profile', href: edit_user_path(@user.id)) }
      it { expect(page).to have_link('Settings', href: '#') }
      it { expect(page).to have_link('Sign out', href: signout_path) }
    it { expect(page).to have_link('Admin', href: '#') }
      it { expect(page).to have_link('Resources', href: '#') }
        it { expect(page).not_to have_link('Companies') }
        it { expect(page).not_to have_link('Currencies') }
        it { expect(page).to have_link('Expenses', href: expenses_path) }
        it { expect(page).not_to have_link('Expense Statuses') }
        it { expect(page).to have_link('Expense Types', href: expense_types_path) }
        it { expect(page).to have_link('Users', href: users_path) }
        it { expect(page).not_to have_link('User Types') }
      it { expect(page).to have_link('Utilities', href: '#') }
        it { expect(page).to have_link('Replace Expense Owner', href: new_replace_expense_owner_path) }
        it { expect(page).to have_link('Replace User Manager', href: new_replace_user_manager_path) }
      it { expect(page).not_to have_link('Delayed Jobs') }
    it { expect(page).to have_link('Expenses', href: '#') }
      it { expect(page).to have_link('New Expense', href: new_expense_path) }
      it { expect(page).to have_link('Submitted Expenses', href: submitted_expenses_path) }
      it { expect(page).to have_link('Owned Expense', href: owned_expenses_path) }
    it { expect(page).to have_link('Help', href: help_path) }
  end

  describe "regular_user" do
    before (:each) do
      @user = create(:regular_user)
      login_in(@user)
    end
    it { expect(page).to have_link('Home', href: root_path) }
    it { expect(page).not_to have_link('Sign in')}
    it { expect(page).to have_link('Account', href: '#') }
      it { expect(page).to have_link('Profile', href: edit_user_path(@user.id)) }
      it { expect(page).to have_link('Settings', href: '#') }
      it { expect(page).to have_link('Sign out', href: signout_path) }
    it { expect(page).not_to have_link('Admin') }
      it { expect(page).not_to have_link('Resources') }
        it { expect(page).not_to have_link('Companies') }
        it { expect(page).not_to have_link('Currencies') }
        it { expect(page).not_to have_link('Expenses', href: expenses_path) }
        it { expect(page).not_to have_link('Expense Statuses') }
        it { expect(page).not_to have_link('Expense Types') }
        it { expect(page).not_to have_link('Users') }
        it { expect(page).not_to have_link('User Types') }
      it { expect(page).not_to have_link('Utilities') }
        it { expect(page).not_to have_link('Replace Expense Owner') }
        it { expect(page).not_to have_link('Replace User Manager') }
      it { expect(page).not_to have_link('Delayed Jobs') }
    it { expect(page).to have_link('Expenses', href: '#') }
      it { expect(page).to have_link('New Expense', href: new_expense_path) }
      it { expect(page).to have_link('Submitted Expenses', href: submitted_expenses_path) }
      it { expect(page).to have_link('Owned Expense', href: owned_expenses_path) }
    it { expect(page).to have_link('Help', href: help_path) }
  end

  describe "guest" do
    before (:each) do
      visit root_path
    end
    it { expect(page).to have_link('Home', href: root_path) }
    it { expect(page).to have_link('Sign in', href: signin_path)}
    it { expect(page).not_to have_link('Account') }
      it { expect(page).not_to have_link('Profile') }
      it { expect(page).not_to have_link('Settings') }
      it { expect(page).not_to have_link('Sign out') }
    it { expect(page).not_to have_link('Admin') }
      it { expect(page).not_to have_link('Resources') }
        it { expect(page).not_to have_link('Companies') }
        it { expect(page).not_to have_link('Currencies') }
        it { expect(page).not_to have_link('Expenses', href: expenses_path) }
        it { expect(page).not_to have_link('Expense Statuses') }
        it { expect(page).not_to have_link('Expense Types') }
        it { expect(page).not_to have_link('Users') }
        it { expect(page).not_to have_link('User Types') }
      it { expect(page).not_to have_link('Utilities') }
        it { expect(page).not_to have_link('Replace Expense Owner') }
        it { expect(page).not_to have_link('Replace User Manager') }
      it { expect(page).not_to have_link('Delayed Jobs') }
    it { expect(page).not_to have_link('Expenses', href: '#') }
      it { expect(page).not_to have_link('New Expense') }
      it { expect(page).not_to have_link('Submitted Expenses') }
      it { expect(page).not_to have_link('Owned Expense') }
    it { expect(page).to have_link('Help', href: help_path) }
  end

end