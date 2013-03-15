require 'spec_helper'

shared_examples("can create user") do  
  describe 'GET #new' do
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{
          post :create, user: attributes_for(:user, company_id: @user.company_id)
        }.to change(User, :count).by(1)
      end
      it "redirects to the index page" do
        post :create, user: attributes_for(:user, company_id: @user.company_id)
        expect(response).to redirect_to users_path
      end
    end
    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, user: attributes_for(:user, name: nil)
        }.to_not change(User, :count)
      end
      it "re-renders the :new template" do
        post :create, user: attributes_for(:user, name: nil)
        expect(response).to render_template :new
      end
    end
  end
end  

shared_examples("can update user") do
  describe 'GET #edit' do
    it "assigns the requested user to @user" do
      get :edit, id: @test_user
      expect(assigns(:user)).to eq @test_user
    end
    it "renders the :edit template" do
      get :edit, id: @test_user
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    it "locates the requested @user" do
      put :update, id: @test_user, user: attributes_for(:user)
      expect(assigns(:user)).to eq(@test_user)
    end
    context "with valid attributes" do
      it "changes @user's attributes" do
        put :update, id: @test_user, user: { name: 'New User' }
        @test_user.reload
        expect(@test_user.name).to eq('New User')
      end
      it "redirects to the index page" do
        put :update, id: @test_user, user: attributes_for(:user)
        expect(response).to redirect_to users_path
      end
    end
    context "with invalid attributes" do
      it "does not change @user's attributes" do
        user_name = @test_user.name
        put :update, id: @test_user, user: attributes_for(:user, name: nil)
        @test_user.reload
        expect(@test_user.name).to eq(user_name)
      end
      it "re-renders the #edit template" do
        put :update, id: @test_user, user: attributes_for(:user, name: nil)
        expect(response).to render_template :edit
      end
    end
  end
end  

shared_examples("can destroy user") do
  describe 'DELETE #destroy' do
    it "deletes the user from the database" do
      expect{
        delete :destroy, id: @test_user
      }.to change(User,:count).by(-1)
    end
    it "redirects to index page" do
      delete :destroy, id: @test_user
      expect(response).to redirect_to users_path
    end
  end
end

shared_examples("can read user") do
  describe 'GET #index' do
    it "populates an array of users" do
      get :index
      expect(assigns(:users)).not_to be_nil
    end
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested user to @user" do
      get :show, id: @test_user
      expect(assigns(:user)).to eq @test_user
    end
    it "renders the :show template" do
      get :show, id: @test_user
      expect(response).to render_template :show
    end
  end
end

shared_examples("can manage user") do
  it_behaves_like "can create user"
  it_behaves_like "can read user"
  it_behaves_like "can update user"
  it_behaves_like "can destroy user"
end

describe UsersController do
  describe "guest access to users" do
    it_behaves_like "having no access", :user, Rails.application.routes.url_helpers.signin_path
  end
  describe "regular_user access to users" do
    before(:each) do
      @user = create(:regular_user)
      sign_in(@user)
    end
    context "signed-in user" do
      before(:each) do
        @test_user = @user
      end
      it_behaves_like "can update user"
    end
    context "user belongs to the company of signed-in user" do
      before(:each) do
        @test_user = create(:regular_user, company_id: @user.company.id)
      end
      it_behaves_like "can read user"
    end
  end
  describe "company admin access to users" do
    before(:each) do
      @user = create(:company_admin)
      sign_in(@user)
      @test_user = create(:user, company: @user.company)
    end
    it_behaves_like "can manage user"
  end
  describe "vendor admin access to users" do
    before(:each) do
      @user = create(:vendor_admin)
      sign_in(@user)
      @test_user = create(:user)
    end
    it_behaves_like "can manage user"
  end
end