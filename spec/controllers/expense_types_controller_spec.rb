require 'spec_helper'

shared_examples("can create expense_type") do  
  describe 'GET #new' do
    it "assigns a new Expense type to @expense_type" do
      get :new
      expect(assigns(:expense_type)).to be_a_new(ExpenseType)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new expense_type in the database" do
        expect{
          post :create, expense_type: attributes_for(:expense_type, company_id: @user.company.id)
        }.to change(ExpenseType, :count).by(1)
      end
      it "redirects to the index page" do
        post :create, expense_type: attributes_for(:expense_type, company_id: @user.company.id)
        expect(response).to redirect_to expense_types_path
      end
    end
    context "with invalid attributes" do
      it "does not save the new expense_type in the database" do
        expect{
          post :create, expense_type: attributes_for(:expense_type, name: nil)
        }.to_not change(ExpenseType, :count)
      end
      it "re-renders the :new template" do
        post :create, expense_type: attributes_for(:expense_type, name: nil)
        expect(response).to render_template :new
      end
    end
  end
end  

shared_examples("can update expense_type") do
  describe 'GET #edit' do
    it "assigns the requested expense_type to @expense_type" do
      get :edit, id: @expense_type
      expect(assigns(:expense_type)).to eq @expense_type
    end
    it "renders the :edit template" do
      get :edit, id: @expense_type
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    it "locates the requested @expense_type" do
      put :update, id: @expense_type, expense_type: attributes_for(:expense_type)
      expect(assigns(:expense_type)).to eq(@expense_type)
    end
    context "with valid attributes" do
      it "changes @expense_type's attributes" do
        put :update, id: @expense_type, expense_type: attributes_for(:expense_type, name: 'New Expense Type')
        @expense_type.reload
        expect(@expense_type.name).to eq('New Expense Type')
      end
      it "redirects to the index page" do
        put :update, id: @expense_type, expense_type: attributes_for(:expense_type)
        expect(response).to redirect_to expense_types_path
      end
    end
    context "with invalid attributes" do
      it "does not change @expense_type's attributes" do
        expense_type_name = @expense_type.name
        put :update, id: @expense_type, expense_type: attributes_for(:expense_type, name: nil)
        @expense_type.reload
        expect(@expense_type.name).to eq(expense_type_name)
      end
      it "re-renders the #edit template" do
        put :update, id: @expense_type, expense_type: attributes_for(:expense_type, name: nil)
        expect(response).to render_template :edit
      end
    end
  end
end  

shared_examples("can destroy expense_type") do
  describe 'DELETE #destroy' do
    it "deletes the expense_type from the database" do
      expect{
        delete :destroy, id: @expense_type
      }.to change(ExpenseType,:count).by(-1)
    end
    it "redirects to index page" do
      delete :destroy, id: @expense_type
      expect(response).to redirect_to expense_types_path
    end
  end
end

shared_examples("can read expense_type") do
  describe 'GET #index' do
    it "populates an array of expense_types" do
      get :index
      expect(assigns(:expense_types)).not_to be_nil
    end
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested expense_type to @expense_type" do
      get :show, id: @expense_type
      expect(assigns(:expense_type)).to eq @expense_type
    end
    it "renders the :show template" do
      get :show, id: @expense_type
      expect(response).to render_template :show
    end
  end
end

shared_examples("can manage expense_type") do
  it_behaves_like "can create expense_type"
  it_behaves_like "can read expense_type"
  it_behaves_like "can update expense_type"
  it_behaves_like "can destroy expense_type"
end

describe ExpenseTypesController do
  describe "guest access to expense_types" do
    it_behaves_like "having no access", :expense_type, Rails.application.routes.url_helpers.signin_path
  end
  describe "regular user access to expense_types" do
    before(:each) do
      @user = create(:regular_user)
      sign_in(@user)
    end
    context "expense type for the company" do
      before(:each) do
        @expense_type = create(:expense_type, company: @user.company)
      end
      it_behaves_like "can read expense_type"
    end
    context "expense type for the vendor" do
      before(:each) do
        @expense_type = create(:expense_type, company_id: Company.vendor_id)
      end
      it_behaves_like "can read expense_type"
    end
  end
  describe "company admin access to expense_types" do
    before(:each) do
      @user = create(:company_admin)
      sign_in(@user)
      @expense_type = create(:expense_type, company: @user.company)
    end
    it_behaves_like "can manage expense_type"
  end
  describe "vendor admin access to expense_types" do
    before(:each) do
      @user = create(:vendor_admin)
      sign_in(@user)
      @expense_type = create(:expense_type)
    end
    it_behaves_like "can manage expense_type"
  end
end