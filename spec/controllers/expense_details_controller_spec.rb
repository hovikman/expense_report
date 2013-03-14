require 'spec_helper'

shared_examples("can create expense_detail") do  
  describe 'GET #new' do
    it "assigns a new Expense detail to @expense_detail" do
      get :new, expense_id: @expense
      expect(assigns(:expense_detail)).to be_a_new(ExpenseDetail)
    end
    it "renders the :new template" do
      get :new, expense_id: @expense
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    before :each do
      @usd_id  = Currency.find_by_code('USD').id
      @meal_id = ExpenseType.find_by_name('Meal').id
    end
    context "with valid attributes" do
      it "saves the new expense_detail in the database" do
        expect{
          post :create, expense_id: @expense,
                        expense_detail: attributes_for(:expense_detail,
                                                       currency_id: @usd_id,
                                                       expense_type_id: @meal_id)
        }.to change(ExpenseDetail, :count).by(1)
      end
      it "redirects to the index page" do
        post :create, expense_id: @expense,
                      expense_detail: attributes_for(:expense_detail,
                                                     currency_id: @usd_id,
                                                     expense_type_id: @meal_id)
        expect(response).to redirect_to get_expense_list_path + '#tab_details'
      end
    end
    context "with invalid attributes" do
      it "does not save the new expense_detail in the database" do
        expect{
          post :create, expense_id: @expense, expense_detail: attributes_for(:expense_detail) 
        }.to_not change(ExpenseDetail, :count)
      end
      it "re-renders the :new template" do
        post :create, expense_id: @expense, expense_detail: attributes_for(:expense_detail)
        expect(response).to render_template :new
      end
    end
  end
end  

shared_examples("can update expense_detail") do
  describe 'GET #edit' do
    it "assigns the requested expense_detail to @expense_detail" do
      get :edit, id: @expense_detail
      expect(assigns(:expense_detail)).to eq @expense_detail
    end
    it "renders the :edit template" do
      get :edit, id: @expense_detail
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    it "locates the requested @expense_detail" do
      put :update, id: @expense_detail, expense_detail: attributes_for(:expense_detail)
      expect(assigns(:expense_detail)).to eq(@expense_detail)
    end
    context "with valid attributes" do
      it "changes @expense_detail's attributes" do
        put :update, id: @expense_detail, expense_detail: attributes_for(:expense_detail, amount: 17.00)
        @expense_detail.reload
        expect(@expense_detail.amount).to eq(17.00)
      end
      it "redirects to the index page" do
        put :update, id: @expense_detail, expense_detail: attributes_for(:expense_detail)
        expect(response).to redirect_to get_expense_list_path + '#tab_details'
      end
    end
    context "with invalid attributes" do
      it "does not change @expense_detail's attributes" do
        expense_detail_date = @expense_detail.date
        put :update, id: @expense_detail, expense_detail: attributes_for(:expense_detail, date: nil)
        @expense_detail.reload
        expect(@expense_detail.date).to eq(expense_detail_date)
      end
      it "re-renders the #edit template" do
        put :update, id: @expense_detail, expense_detail: attributes_for(:expense_detail, date: nil)
        expect(response).to render_template :edit
      end
    end
  end
end  

shared_examples("can destroy expense_detail") do
  describe 'DELETE #destroy' do
    it "deletes the expense_detail from the database" do
      expect{
        delete :destroy, id: @expense_detail
      }.to change(ExpenseDetail,:count).by(-1)
    end
    it "redirects to index page" do
      delete :destroy, id: @expense_detail
      expect(response).to redirect_to get_expense_list_path + '#details'
    end
  end
end

shared_examples("can read expense_detail") do
  describe 'GET #index' do
    it "populates an array of expense_details" do
      get :index, expense_id: @expense
      expect(assigns(:expense_details)).not_to be_nil
    end
    it "renders the :index view" do
      get :index, expense_id: @expense
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested expense_detail to @expense_detail" do
      get :show, id: @expense_detail
      expect(assigns(:expense_detail)).to eq @expense_detail
    end
    it "renders the :show template" do
      get :show, id: @expense_detail
      expect(response).to render_template :show
    end
  end
end

shared_examples("can manage expense_detail") do
  it_behaves_like "can create expense_detail"
  it_behaves_like "can read expense_detail"
  it_behaves_like "can update expense_detail"
  it_behaves_like "can destroy expense_detail"
end

describe ExpenseDetailsController do
  describe "guest access to expense_details" do
    it_behaves_like "having no access", :expense_detail, Rails.application.routes.url_helpers.signin_path
  end
  describe "regular user access to expense_details" do
    before(:each) do
      @user = create(:regular_user)
      sign_in(@user)
      @expense = create(:expense, user: @user)
      @expense_detail = create(:expense_detail, expense: @expense)
    end
    it_behaves_like "can manage expense_detail"
  end
  describe "company admin access to expense_details" do
    before(:each) do
      @user = create(:company_admin)
      sign_in(@user)
      regular_user = create(:regular_user, company: @user.company)
      @expense = create(:expense, user: regular_user)
      @expense_detail = create(:expense_detail, expense: @expense)
    end
    it_behaves_like "can manage expense_detail"
  end
  describe "vendor admin access to expense_details" do
    before(:each) do
      @user = create(:vendor_admin)
      sign_in(@user)
      @expense = create(:expense)
      @expense_detail = create(:expense_detail, expense: @expense)
    end
    it_behaves_like "can manage expense_detail"
  end
end