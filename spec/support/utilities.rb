include ApplicationHelper

shared_examples_for "all static pages" do
  it { should have_selector('h1',    text: heading) }
  it { should have_title(full_title(page_title)) }
end

RSpec::Matchers::define :have_title do |text|
  match do |page|
    Capybara.string(page.body).has_selector?('title', text: text)
  end
end

shared_examples("having no access") do |model, redirect_path|
  describe 'GET #index' do
    it "requires login" do
      get :index
      expect(response).to redirect_to redirect_path
    end
  end
  describe 'GET #show' do
    it "requires login" do
      model_obj = create(model)
      get :show, id: model_obj
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
      get :edit, id: create(model)
      expect(response).to redirect_to redirect_path
    end
  end
  describe "POST #create" do
    it "requires login" do
      post :create, id: create(model), model => attributes_for(model)
      expect(response).to redirect_to redirect_path
    end
  end
  describe 'PUT #update' do
    it "requires login" do
      put :update, id: create(model), model => attributes_for(model)
      expect(response).to redirect_to redirect_path
    end
  end
  describe 'DELETE #destroy' do
    it "requires login" do
      delete :destroy, id: create(model)
      expect(response).to redirect_to redirect_path
    end
  end
end