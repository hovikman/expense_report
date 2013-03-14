require 'spec_helper'

shared_examples("can create expense") do  
  describe 'GET #new' do
    it "assigns a new Expense to @expense" do
      get :new, expense_id: @expense
      expect(assigns(:expense)).to be_a_new(Expense)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new expense in the database" do
        expect{
          post :create, expense: attributes_for(:expense, user_id: @expense.user.id)
        }.to change(Expense, :count).by(1)
      end
      it "redirects to the index page" do
        post :create, expense: attributes_for(:expense, user_id: @expense.user.id)
        expect(response).to redirect_to expenses_path + '/submitted'
      end
    end
    context "with invalid attributes" do
      it "does not save the new expense in the database" do
        expect{
          post :create, expense: attributes_for(:expense) 
        }.to_not change(Expense, :count)
      end
      it "re-renders the :new template" do
        post :create, expense: attributes_for(:expense)
        expect(response).to render_template :new
      end
    end
  end
end  

shared_examples("can update expense") do
  describe 'GET #edit' do
    it "assigns the requested expense to @expense" do
      get :edit, id: @expense
      expect(assigns(:expense)).to eq @expense
    end
    it "renders the :edit template" do
      get :edit, id: @expense
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    it "locates the requested @expense" do
      put :update, id: @expense, expense: attributes_for(:expense)
      expect(assigns(:expense)).to eq(@expense)
    end
    context "with valid attributes" do
      it "changes @expense's attributes" do
        put :update, id: @expense, expense: attributes_for(:expense, advance_pay: 23.00)
        @expense.reload
        expect(@expense.advance_pay).to eq(23.00)
      end
      it "redirects to the index page" do
        put :update, id: @expense, expense: attributes_for(:expense)
        expect(response).to redirect_to expenses_path + '/submitted'
      end
    end
    context "with invalid attributes" do
      it "does not change @expense's attributes" do
        expense_submit_date = @expense.submit_date
        put :update, id: @expense, expense: attributes_for(:expense, submit_date: nil)
        @expense.reload
        expect(@expense.submit_date).to eq(expense_submit_date)
      end
      it "re-renders the #edit template" do
        put :update, id: @expense, expense: attributes_for(:expense, submit_date: nil)
        expect(response).to render_template :edit
      end
    end
  end
end  

shared_examples("can destroy expense") do
  describe 'DELETE #destroy' do
    it "deletes the expense from the database" do
      expect{
        delete :destroy, id: @expense
      }.to change(Expense,:count).by(-1)
    end
    it "redirects to index page" do
      delete :destroy, id: @expense
      expect(response).to redirect_to expenses_path + '/submitted'
    end
  end
end

shared_examples("can read expense") do
  describe 'GET #index' do
    it "populates an array of expense" do
      get :index
      expect(assigns(:expenses)).not_to be_nil
    end
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested expense to @expense" do
      get :show, id: @expense
      expect(assigns(:expense)).to eq @expense
    end
    it "renders the :show template" do
      get :show, id: @expense
      expect(response).to render_template :show
    end
  end
end

shared_examples("can view owned expense") do
  before(:each) do
    @expense.owner_id = @user.id
  end
  describe 'GET #owned' do
    it "populates an array of owned expenses" do
      get :owned
      expect(assigns(:expenses)).not_to be_nil
    end
    it "renders the :owned view" do
      get :owned
      expect(response).to render_template :index
    end
  end
end

shared_examples("can view submitted expense") do
  before(:each) do
    @expense.user_id = @user.id
  end
  describe 'GET #submitted' do
    it "populates an array of submitted expenses" do
      get :submitted
      expect(assigns(:expenses)).not_to be_nil
    end
    it "renders the :owned view" do
      get :submitted
      expect(response).to render_template :index
    end
  end
end

shared_examples("can view transition_buttons") do
  describe 'GET #transition_buttons' do
    it "assigns the requested expense to @expense" do
      get :transition_buttons, id: @expense
      expect(assigns(:expense)).to eq @expense
    end
    it "renders the :transition_buttons template" do
      get :transition_buttons, id: @expense
      expect(response).to render_template 'transition_buttons'
    end
  end
end

shared_examples("can change_state") do
  pending "need more time to understand how to do it"
end

shared_examples("can manage expense") do
  it_behaves_like "can create expense"
  it_behaves_like "can read expense"
  it_behaves_like "can update expense"
  it_behaves_like "can destroy expense"
  it_behaves_like "can destroy expense"
  it_behaves_like "can view owned expense"
  it_behaves_like "can view submitted expense"
  it_behaves_like "can view transition_buttons"
  it_behaves_like "can change_state"
end

describe ExpensesController do
  describe "guest access to expenses" do
    it_behaves_like "having no access", :expense, Rails.application.routes.url_helpers.signin_path
  end
  describe "regular user access to expenses" do
    before(:each) do
      @user = create(:regular_user)
      sign_in(@user)
      @expense = create(:expense, user: @user)
    end
    it_behaves_like "can manage expense"
  end
  describe "company admin access to expenses" do
    before(:each) do
      @user = create(:company_admin)
      sign_in(@user)
      @regular_user = create(:regular_user, company: @user.company)
      @expense = create(:expense, user: @regular_user)
    end
    it_behaves_like "can manage expense"
  end
  describe "vendor admin access to expenses" do
    before(:each) do
      @user = create(:vendor_admin)
      sign_in(@user)
      @expense = create(:expense)
    end
    it_behaves_like "can manage expense"
  end
end