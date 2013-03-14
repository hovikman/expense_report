require 'spec_helper'

describe UserTypesController do
  describe "guest access to user types" do
    it_behaves_like "having no access", :user_type, Rails.application.routes.url_helpers.signin_path
  end
  
  describe "regular user access to user_types" do
    before(:each) do
      sign_in(create(:regular_user))
    end
    it_behaves_like "having no access", :user_type, Rails.application.routes.url_helpers.root_path
  end
  
  describe "company admin access to user_types" do
    before(:each) do
      sign_in(create(:company_admin))
    end
    it_behaves_like "having no access", :user_type, Rails.application.routes.url_helpers.root_path
  end
  
  describe "vendor admin access to user_type" do
    before(:each) do
      sign_in(create(:vendor_admin))
    end
    describe 'GET #index' do
      it "populates an array of user_types" do
        get :index
        expect(assigns(:user_types)).not_to be_nil
      end
      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end
  
    describe 'GET #show' do
      it "assigns the requested user_type to @user_type" do
        user_type = create(:user_type)
        get :show, id: user_type
        expect(assigns(:user_type)).to eq user_type
      end
      it "renders the :show template" do
        user_type = create(:user_type)
        get :show, id: user_type
        expect(response).to render_template :show
      end
    end
  
    describe 'GET #new' do
      it "assigns a new UserType to @user_type" do
        get :new
        expect(assigns(:user_type)).to be_a_new(UserType)
      end
      it "redirects to home page" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  
    describe 'GET #edit' do
      it "assigns the requested user_type to @user_type" do
        user_type = create(:user_type)
        get :edit, id: user_type
        expect(assigns(:user_type)).to eq user_type
      end
      it "redirects to home page" do
        user_type = create(:user_type)
        get :edit, id: user_type
        expect(response).to redirect_to root_path
      end
    end
  
    describe "POST #create" do
      context "with valid attributes" do
        it "does not save the new user_type in the database" do
          expect{
            post :create, user_type: attributes_for(:user_type) 
          }.not_to change(UserType, :count)
        end
        it "redirects to home page" do
          post :create, user_type: attributes_for(:user_type)
          expect(response).to redirect_to root_path
        end
      end
  
      context "with invalid attributes" do
        it "does not save the new user_type in the database" do
          expect{
            post :create, user_type: attributes_for(:user_type, name: nil) 
          }.to_not change(UserType, :count)
        end
        it "redirects the home page" do
          post :create, user_type: attributes_for(:user_type, name: nil)
          expect(response).to redirect_to root_path
        end
      end
    end
  
    describe 'PUT #update' do
      before :each do
        @user_type = create(:user_type)
      end
      
      it "locates the requested @user_type" do
        put :update, id: @user_type, user_type: attributes_for(:user_type)
        expect(assigns(:user_type)).to eq(@user_type)
      end
      
      context "with valid attributes" do
        it "does not change @user_type's attributes" do
          put :update, id: @user_type, user_type: attributes_for(:user_type, name: 'New User Type')
          @user_type.reload
          expect(@user_type.name).not_to eq('New User Type')
        end
        it "redirects to home page" do
          put :update, id: @user_type, user_type: attributes_for(:user_type)
          expect(response).to redirect_to root_path
        end
      end
  
      context "with invalid attributes" do
        it "does not change @user_type's attributes" do
          user_type_name = @user_type.name
          put :update, id: @user_type, user_type: attributes_for(:user_type, name: nil)
          @user_type.reload
          expect(@user_type.name).to eq(user_type_name)
        end
        it "redirects to home page" do
          put :update, id: @user_type, user_type: attributes_for(:user_type, name: nil)
          expect(response).to redirect_to root_path
        end
      end
    end
  
    describe 'DELETE #destroy' do
      before :each do
        @user_type = create(:user_type)
      end
  
      it "does not delete the user_type from the database" do
        expect{
          delete :destroy, id: @user_type
        }.not_to change(UserType,:count)
      end
      it "redirects to home page" do
        delete :destroy, id: @user_type
        expect(response).to redirect_to root_path
      end
    end
  end
end