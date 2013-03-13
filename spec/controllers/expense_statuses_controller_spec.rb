require 'spec_helper'

describe ExpenseStatusesController do
  describe "guest access to expense statuses" do
    it_behaves_like "having no access", :expense_status, Rails.application.routes.url_helpers.signin_path
  end
  
  describe "regular user access to expense_statuses" do
    before(:each) do
      sign_in(create(:regular_user))
    end
    it_behaves_like "having no access", :expense_status, Rails.application.routes.url_helpers.root_path
  end
  
  describe "company admin access to expense_statuses" do
    before(:each) do
      sign_in(create(:company_admin))
    end
    it_behaves_like "having no access", :expense_status, Rails.application.routes.url_helpers.root_path
  end
  
  describe "vendor admin access to expense_statuses" do
    before(:each) do
      sign_in(create(:vendor_admin))
    end
    describe 'GET #index' do
      it "populates an array of expense_statuses" do
        get :index
        expect(assigns(:expense_statuses)).not_to be_nil
      end
      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end
  
    describe 'GET #show' do
      it "assigns the requested expense_status to @expense_status" do
        expense_status = create(:expense_status)
        get :show, id: expense_status
        expect(assigns(:expense_status)).to eq expense_status
      end
      it "renders the :show template" do
        expense_status = create(:expense_status)
        get :show, id: expense_status
        expect(response).to render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new ExpenseStatus to @expense_status" do
        get :new
        expect(assigns(:expense_status)).to be_a_new(ExpenseStatus)
      end
      it "redirects to home page" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  
    describe 'GET #edit' do
      it "assigns the requested expense_status to @expense_status" do
        expense_status = create(:expense_status)
        get :edit, id: expense_status
        expect(assigns(:expense_status)).to eq expense_status
      end
      it "redirects to home page" do
        expense_status = create(:expense_status)
        get :edit, id: expense_status
        expect(response).to redirect_to root_path
      end
    end
  
    describe "POST #create" do
      context "with valid attributes" do
        it "does not save the new expense_status in the database" do
          expect{
            post :create, expense_status: attributes_for(:expense_status) 
          }.not_to change(ExpenseStatus, :count)
        end
        it "redirects to home page" do
          post :create, expense_status: attributes_for(:expense_status)
          expect(response).to redirect_to root_path
        end
      end
  
      context "with invalid attributes" do
        it "does not save the new expense_status in the database" do
          expect{
            post :create, expense_status: attributes_for(:expense_status, name: nil) 
          }.to_not change(ExpenseStatus, :count)
        end
        it "redirects the home page" do
          post :create, expense_status: attributes_for(:expense_status, name: nil)
          expect(response).to redirect_to root_path
        end
      end
    end
  
    describe 'PUT #update' do
      before :each do
        @expense_status = create(:expense_status)
      end
      
      it "locates the requested @expense_status" do
        put :update, id: @expense_status, expense_status: attributes_for(:expense_status)
        expect(assigns(:expense_status)).to eq(@expense_status)
      end
      
      context "with valid attributes" do
        it "does not change @expense_status's attributes" do
          put :update, id: @expense_status, expense_status: attributes_for(:expense_status, name: 'New Status')
          @expense_status.reload
          expect(@expense_status.name).not_to eq('New Status')
        end
        it "redirects to home page" do
          put :update, id: @expense_status, expense_status: attributes_for(:expense_status)
          expect(response).to redirect_to root_path
        end
      end
  
      context "with invalid attributes" do
        it "does not change @expense_status's attributes" do
          expense_status_name = @expense_status.name
          put :update, id: @expense_status, expense_status: attributes_for(:expense_status, name: nil)
          @expense_status.reload
          expect(@expense_status.name).to eq(expense_status_name)
        end
        it "redirects to home page" do
          put :update, id: @expense_status, expense_status: attributes_for(:expense_status, name: nil)
          expect(response).to redirect_to root_path
        end
      end
    end
  
    describe 'DELETE #destroy' do
      before :each do
        @expense_status = create(:expense_status)
      end
  
      it "does not delete the expense_status from the database" do
        expect{
          delete :destroy, id: @expense_status
        }.not_to change(ExpenseStatus,:count)
      end
      it "redirects to home page" do
        delete :destroy, id: @expense_status
        expect(response).to redirect_to root_path
      end
    end
  end
end