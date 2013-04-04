require 'spec_helper'

shared_examples("can create reject_note") do  
  describe 'GET #new' do
    it "assigns a new Reject note to @reject_note" do
      get :new, expense_id: @expense
      expect(assigns(:reject_note)).to be_a_new(RejectNote)
    end
    it "renders the :new template" do
      get :new, expense_id: @expense
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new reject_note in the database" do
        expect{
          post :create, expense_id: @expense, reject_note: attributes_for(:reject_note)
        }.to change(RejectNote, :count).by(1)
      end
      it "redirects to the index page" do
        post :create, expense_id: @expense, reject_note: attributes_for(:reject_note)
        expect(response).to redirect_to get_expense_list_path + '#tab_reject_notes'
      end
    end
    context "with invalid attributes" do
      it "does not save the new reject_note in the database" do
        expect{
          post :create, expense_id: @expense, reject_note: attributes_for(:reject_note, date: nil) 
        }.to_not change(RejectNote, :count)
      end
      it "re-renders the :new template" do
        post :create, expense_id: @expense, reject_note: attributes_for(:reject_note)
        expect(response).to render_template :new
      end
    end
  end
end  

shared_examples("can update reject_note") do
  describe 'GET #edit' do
    it "assigns the requested reject_note to @reject_note" do
      get :edit, id: @reject_note
      expect(assigns(:reject_note)).to eq @reject_note
    end
    it "renders the :edit template" do
      get :edit, id: @reject_note
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    it "locates the requested @reject_note" do
      put :update, id: @reject_note, reject_note: attributes_for(:reject_note)
      expect(assigns(:reject_note)).to eq(@reject_note)
    end
    context "with valid attributes" do
      it "changes @reject_note's attributes" do
        put :update, id: @reject_note, reject_note: attributes_for(:reject_note, content: 'sample text')
        @reject_note.reload
        expect(@reject_note.content).to eq('sample text')
      end
      it "redirects to the index page" do
        put :update, id: @reject_note, reject_note: attributes_for(:reject_note)
        expect(response).to redirect_to get_expense_list_path + '#tab_reject_notes'
      end
    end
    context "with invalid attributes" do
      it "does not change @reject_note's attributes" do
        reject_note_date = @reject_note.date
        put :update, id: @reject_note, reject_note: attributes_for(:reject_note, date: nil)
        @reject_note.reload
        expect(@reject_note.date).to eq(reject_note_date)
      end
      it "re-renders the #edit template" do
        put :update, id: @reject_note, reject_note: attributes_for(:reject_note, date: nil)
        expect(response).to render_template :edit
      end
    end
  end
end  

shared_examples("can destroy expense_note") do
  describe 'DELETE #destroy' do
    it "deletes the reject_note from the database" do
      expect{
        delete :destroy, id: @reject_note
      }.to change(RejectNote,:count).by(-1)
    end
    it "redirects to index page" do
      delete :destroy, id: @reject_note
      expect(response).to redirect_to get_expense_list_path + '#reject_notes'
    end
  end
end

shared_examples("can read reject_note") do
  describe 'GET #index' do
    it "populates an array of reject_notes" do
      get :index, expense_id: @expense
      expect(assigns(:reject_note)).not_to be_nil
    end
    it "renders the :index view" do
      get :index, expense_id: @expense
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested reject_note to @reject_note" do
      get :show, id: @reject_note
      expect(assigns(:reject_note)).to eq @reject_note
    end
    it "renders the :show template" do
      get :show, id: @reject_note
      expect(response).to render_template :show
    end
  end
end

shared_examples("can manage reject_note") do
  it_behaves_like "can create reject_note"
  it_behaves_like "can read reject_note"
  it_behaves_like "can update reject_note"
  it_behaves_like "can destroy reject_note"
end

describe RejectNotesController do
  describe "guest access to reject_notes" do
    it_behaves_like "having no access", :reject_note, Rails.application.routes.url_helpers.signin_path
  end
  describe "regular user access to reject_notes" do
    before(:each) do
      @user = create(:regular_user)
      sign_in(@user)
      @expense = create(:expense, user: @user)
      @reject_note = create(:reject_note, expense: @expense)
    end
    it_behaves_like "can manage reject_note"
  end
  describe "company admin access to reject_notes" do
    before(:each) do
      @user = create(:company_admin)
      sign_in(@user)
      regular_user = create(:regular_user, company: @user.company)
      @expense = create(:expense, user: regular_user)
      @reject_note = create(:reject_note, expense: @expense)
    end
    it_behaves_like "can manage reject_note"
  end
  describe "vendor admin access to reject_notes" do
    before(:each) do
      @user = create(:vendor_admin)
      sign_in(@user)
      @expense = create(:expense)
      @reject_note = create(:reject_note, expense: @expense)
    end
    it_behaves_like "can manage reject_note"
  end
end