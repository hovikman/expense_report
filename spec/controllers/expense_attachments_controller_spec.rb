require 'spec_helper'

shared_examples("can create") do  
  describe 'GET #new' do
    it "assigns a new Expense attachment to @expense_attachment" do
      get :new, expense_id: @expense
      expect(assigns(:expense_attachment)).to be_a_new(ExpenseAttachment)
    end
    it "renders the :new template" do
      get :new, expense_id: @expense
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new expense_attachment in the database" do
        pending("uploader tests") do
          expect{
            post :create, expense_id: @expense, expense_attachment: attributes_for(:expense_attachment)
          }.to change(ExpenseAttachment, :count).by(1)
        end
      end
      it "redirects to the index page" do
        pending("uploader tests") do
          post :create, expense_id: @expense, expense_attachment: attributes_for(:expense_attachment)
          expect(response).to redirect_to get_expense_list_path + '#tab_attachments'
        end
      end
    end
    context "with invalid attributes" do
      it "does not save the new expense_attachment in the database" do
        expect{
          post :create, expense_id: @expense, expense_attachment: attributes_for(:expense_attachment, expense: @expense, description: nil) 
        }.to_not change(ExpenseAttachment, :count)
      end
      it "re-renders the :new template" do
        post :create, expense_id: @expense, expense_attchment: attributes_for(:expense_attachment, expense: @expense, description: nil)
        expect(response).to render_template :new
      end
    end
  end
end  

shared_examples("can update") do
  describe 'GET #edit' do
    it "assigns the requested expense_attachment to @expense_attachment" do
      get :edit, id: @expense_attachment
      expect(assigns(:expense_attachment)).to eq @expense_attachment
    end
    it "renders the :edit template" do
      get :edit, id: @expense_attachment
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    it "locates the requested @expense_attachment" do
      put :update, id: @expense_attachment, expense_attachment: attributes_for(:expense_attachment)
      expect(assigns(:expense_attachment)).to eq(@expense_attachment)
    end
    context "with valid attributes" do
      it "changes @expense_attachment's attributes" do
        put :update, id: @expense_attachment, expense_attachment: attributes_for(:expense_attachment, description: 'New description')
        @expense_attachment.reload
        expect(@expense_attachment.description).to eq('New description')
      end
      it "redirects to the index page" do
        put :update, id: @expense_attachment, expense_attachment: attributes_for(:expense_attachment)
        expect(response).to redirect_to get_expense_list_path + '#tab_attachments'
      end
    end
    context "with invalid attributes" do
      it "does not change @expense_attachment's attributes" do
        description = @expense_attachment.description
        put :update, id: @expense_attachment, expense_attachment: attributes_for(:expense_attachment, description: nil)
        @expense_attachment.reload
        expect(@expense_attachment.description).to eq(description)
      end
      it "re-renders the #edit template" do
        put :update, id: @expense_attachment, expense_attachment: attributes_for(:expense_attachment, description: nil)
        expect(response).to render_template :edit
      end
    end
  end
end  

shared_examples("can destroy") do
  describe 'DELETE #destroy' do
    it "deletes the expense_attachment from the database" do
      expect{
        delete :destroy, id: @expense_attachment
      }.to change(ExpenseAttachment,:count).by(-1)
    end
    it "redirects to index page" do
      delete :destroy, id: @expense_attachment
      expect(response).to redirect_to get_expense_list_path + '#tab_attachments'
    end
  end
end

shared_examples("can read") do
  describe 'GET #index' do
    it "populates an array of expense_attachments" do
      get :index, expense_id: @expense
      expect(assigns(:expense_attachments)).not_to be_nil
    end
    it "renders the :index view" do
      get :index, expense_id: @expense
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested expense_attachment to @expense_attachment" do
      get :show, id: @expense_attachment
      expect(assigns(:expense_attachment)).to eq @expense_attachment
    end
    it "renders the :show template" do
      get :show, id: @expense_attachment
      pending "need to find out how to test send_file function"
    end
  end
end

shared_examples("having proper permissions") do
  it_behaves_like "can create"
  it_behaves_like "can update"
  it_behaves_like "can destroy"
  it_behaves_like "can read"
end

describe ExpenseAttachmentsController do
  describe "guest access to expense_attachments" do
    it_behaves_like "having no access", :expense_attachment, Rails.application.routes.url_helpers.signin_path
  end
  describe "regular user access to expense_attachments" do
    before(:each) do
      @user = create(:regular_user)
      sign_in(@user)
      @expense = create(:expense, user: @user)
      @expense_attachment = create(:expense_attachment, expense: @expense)
    end
    it_behaves_like "having proper permissions"
  end
  describe "company admin access to expense_attachments" do
    before(:each) do
      @user = create(:company_admin)
      sign_in(@user)
      regular_user = create(:regular_user, company: @user.company)
      @expense = create(:expense, user: regular_user)
      @expense_attachment = create(:expense_attachment, expense: @expense)
    end
    it_behaves_like "having proper permissions"
  end
  describe "vendor admin access to expense_attachments" do
    before(:each) do
      @user = create(:vendor_admin)
      sign_in(@user)
      @expense = create(:expense)
      @expense_attachment = create(:expense_attachment, expense: @expense)
    end
    it_behaves_like "having proper permissions"
  end
end