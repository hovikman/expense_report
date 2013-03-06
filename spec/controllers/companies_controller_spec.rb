require 'spec_helper'

describe CompaniesController do
  describe "guest access" do
    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to redirect_to signin_path
      end
    end
    describe 'GET #show' do
      it "requires login" do
        get :show, id: 1
        expect(response).to redirect_to signin_path
      end
    end
    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to redirect_to signin_path
      end
    end
    describe "GET #edit" do
      it "requires login" do
        get :edit, id: create(:company)
        expect(response).to redirect_to signin_path
      end
    end
    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:company), company: attributes_for(:company)
        expect(response).to redirect_to signin_path
      end
    end
    describe 'PUT #update' do
      it "requires login" do
        put :update, id: create(:company), company: attributes_for(:company)
        expect(response).to redirect_to signin_path
      end
    end
    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:company)
        expect(response).to redirect_to signin_path
      end
    end
  end
  
  describe "regular user access" do
    before(:each) do
      @user = create(:regular_user)
      sign_in(@user)
    end
    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to redirect_to root_path
      end
    end
    describe 'GET #show' do
      it "requires login" do
        get :show, id: 1
        expect(response).to redirect_to root_path
      end
    end
    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
    describe "GET #edit" do
      it "requires login" do
        get :edit, id: create(:company)
        expect(response).to redirect_to root_path
      end
    end
    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:company), company: attributes_for(:company)
        expect(response).to redirect_to root_path
      end
    end
    describe 'PUT #update' do
      it "requires login" do
        put :update, id: create(:company), company: attributes_for(:company)
        expect(response).to redirect_to root_path
      end
    end
    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:company)
        expect(response).to redirect_to root_path
      end
    end
  end
  
  describe "company admin access" do
    before(:each) do
      @user = create(:company_admin)
      sign_in(@user)
    end
    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to redirect_to root_path
      end
    end
    describe 'GET #show' do
      it "requires login" do
        get :show, id: 1
        expect(response).to redirect_to root_path
      end
    end
    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
    describe "GET #edit" do
      it "requires login" do
        get :edit, id: create(:company)
        expect(response).to redirect_to root_path
      end
    end
    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:company), company: attributes_for(:company)
        expect(response).to redirect_to root_path
      end
    end
    describe 'PUT #update' do
      it "requires login" do
        put :update, id: create(:company), company: attributes_for(:company)
        expect(response).to redirect_to root_path
      end
    end
    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:company)
        expect(response).to redirect_to root_path
      end
    end
  end
  
  describe "vendor admin access" do
    before(:each) do
      @user = create(:vendor_admin)
      sign_in(@user)
    end
    describe 'GET #index' do
      it "populates an array of companies" do
        company = Company.find(Company.vendor_id)
        get :index
        expect(assigns(:companies)).to match_array [company]
      end
      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end
  
    describe 'GET #show' do
      it "assigns the requested company to @company" do
        company = create(:company)
        get :show, id: company
        expect(assigns(:company)).to eq company
      end
      it "renders the :show template" do
        company = create(:company)
        get :show, id: company
        expect(response).to render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Company to @company" do
        get :new
        expect(assigns(:company)).to be_a_new(Company)
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end
  
    describe 'GET #edit' do
      it "assigns the requested company to @company" do
        company = create(:company)
        get :edit, id: company
        expect(assigns(:company)).to eq company
      end
      it "renders the :edit template" do
        company = create(:company)
        get :edit, id: company
        expect(response).to render_template :edit
      end
    end
  
    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new company in the database" do
          expect{
            post :create, company: attributes_for(:company, currency_id: Currency.find_by_code('USD').id) 
          }.to change(Company, :count).by(1)
        end
        it "redirects to the index page" do
          post :create, company: attributes_for(:company, currency_id: Currency.find_by_code('USD').id)
          expect(response).to redirect_to companies_path
        end
      end
  
      context "with invalid attributes" do
        it "does not save the new company in the database" do
          expect{
            post :create, company: attributes_for(:company) 
          }.to_not change(Company, :count)
        end
        it "re-renders the :new template" do
          post :create, company: attributes_for(:company)
          expect(response).to render_template :new
        end
      end
    end
  
    describe 'PUT #update' do
      before :each do
        @company = create(:company)
      end
      
      it "locates the requested @company" do
        put :update, id: @company, company: attributes_for(:company)
        expect(assigns(:company)).to eq(@company)
      end
      
      context "with valid attributes" do
        it "changes @company's attributes" do
          put :update, id: @company, company: attributes_for(:company, name: 'New Company')
          @company.reload
          expect(@company.name).to eq('New Company')
        end
        it "redirects to the index page" do
          put :update, id: @company, company: attributes_for(:company)
          expect(response).to redirect_to companies_path
        end
      end
  
      context "with invalid attributes" do
        it "does not change @company's attributes" do
          company_name = @company.name
          put :update, id: @company, company: attributes_for(:company, name: "New Company", contact_email: nil)
          @company.reload
          expect(@company.name).to eq(company_name)
        end
        it "re-renders the #edit template" do
          put :update, id: @company, company: attributes_for(:company, contact_email: nil)
          expect(response).to render_template :edit
        end
      end
    end
  
    describe 'DELETE #destroy' do
      before :each do
        @company = create(:company)
      end
  
      it "deletes the company from the database" do
        expect{
          delete :destroy, id: @company
        }.to change(Company,:count).by(-1)
      end
      it "redirects to index page" do
        delete :destroy, id: @company
        expect(response).to redirect_to companies_path
      end
    end
  end
end