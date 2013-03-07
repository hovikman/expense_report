require 'spec_helper'

describe CurrenciesController do
  shared_examples("public access to currencies") do |redirect_path|
    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to redirect_to redirect_path
      end
    end
    describe 'GET #show' do
      it "requires login" do
        get :show, id: 1
        expect(response).to redirect_to redirect_path
      end
    end
    describe "GET #new" do
      it "requires login" do
        get :new
        expect(response).to redirect_to redirect_path
      end
    end
    describe "GET #edit" do
      it "requires login" do
        get :edit, id: create(:currency)
        expect(response).to redirect_to redirect_path
      end
    end
    describe "POST #create" do
      it "requires login" do
        post :create, id: create(:currency), currency: attributes_for(:currency)
        expect(response).to redirect_to redirect_path
      end
    end
    describe 'PUT #update' do
      it "requires login" do
        put :update, id: create(:currency), currency: attributes_for(:currency)
        expect(response).to redirect_to redirect_path
      end
    end
    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: create(:currency)
        expect(response).to redirect_to redirect_path
      end
    end
    describe 'get_exchange_rate' do
      pending "need more time to understand how to do it"
    end
  end

  describe "guest access to currencies" do
    it_behaves_like "public access to currencies", Rails.application.routes.url_helpers.signin_path
  end
  
  describe "regular user access to currencies" do
    before(:each) do
      sign_in(create(:regular_user))
    end
    it_behaves_like "public access to currencies", Rails.application.routes.url_helpers.root_path
  end
  
  describe "company admin access to currencies" do
    before(:each) do
      sign_in(create(:company_admin))
    end
    it_behaves_like "public access to currencies", Rails.application.routes.url_helpers.root_path
  end
  
  describe "vendor admin access to currencies" do
    before(:each) do
      sign_in(create(:vendor_admin))
    end
    describe 'GET #index' do
      it "populates an array of currencies" do
        get :index
        expect(assigns(:currencies)).not_to be_nil
      end
      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end
  
    describe 'GET #show' do
      it "assigns the requested currency to @currency" do
        currency = create(:currency)
        get :show, id: currency
        expect(assigns(:currency)).to eq currency
      end
      it "renders the :show template" do
        currency = create(:currency)
        get :show, id: currency
        expect(response).to render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new Currency to @currency" do
        get :new
        expect(assigns(:currency)).to be_a_new(Currency)
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end
  
    describe 'GET #edit' do
      it "assigns the requested currency to @currency" do
        currency = create(:currency)
        get :edit, id: currency
        expect(assigns(:currency)).to eq currency
      end
      it "renders the :edit template" do
        currency = create(:currency)
        get :edit, id: currency
        expect(response).to render_template :edit
      end
    end
  
    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new currency in the database" do
          expect{
            post :create, currency: attributes_for(:currency) 
          }.to change(Currency, :count).by(1)
        end
        it "redirects to the index page" do
          post :create, currency: attributes_for(:currency)
          expect(response).to redirect_to currencies_path
        end
      end
  
      context "with invalid attributes" do
        it "does not save the new currency in the database" do
          expect{
            post :create, currency: attributes_for(:currency, code: nil) 
          }.to_not change(Currency, :count)
        end
        it "re-renders the :new template" do
          post :create, currency: attributes_for(:currency, code: nil)
          expect(response).to render_template :new
        end
      end
    end
  
    describe 'PUT #update' do
      before :each do
        @currency = create(:currency)
      end
      
      it "locates the requested @currency" do
        put :update, id: @currency, currency: attributes_for(:currency)
        expect(assigns(:currency)).to eq(@currency)
      end
      
      context "with valid attributes" do
        it "changes @currency's attributes" do
          put :update, id: @currency, currency: attributes_for(:currency, name: 'New Currency')
          @currency.reload
          expect(@currency.name).to eq('New Currency')
        end
        it "redirects to the index page" do
          put :update, id: @currency, currency: attributes_for(:currency)
          expect(response).to redirect_to currencies_path
        end
      end
  
      context "with invalid attributes" do
        it "does not change @currency's attributes" do
          currency_name = @currency.name
          put :update, id: @currency, currency: attributes_for(:currency, name: "New Currency", code: nil)
          @currency.reload
          expect(@currency.name).to eq(currency_name)
        end
        it "re-renders the #edit template" do
          put :update, id: @currency, currency: attributes_for(:currency, code: nil)
          expect(response).to render_template :edit
        end
      end
    end
  
    describe 'DELETE #destroy' do
      before :each do
        @currency = create(:currency)
      end
  
      it "deletes the currency from the database" do
        expect{
          delete :destroy, id: @currency
        }.to change(Currency,:count).by(-1)
      end
      it "redirects to index page" do
        delete :destroy, id: @currency
        expect(response).to redirect_to currencies_path
      end
    end
  end
end