require "spec_helper"

describe ExpenseAttachmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/expense_attachments").should route_to("expense_attachments#index")
    end

    it "routes to #new" do
      get("/expense_attachments/new").should route_to("expense_attachments#new")
    end

    it "routes to #show" do
      get("/expense_attachments/1").should route_to("expense_attachments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/expense_attachments/1/edit").should route_to("expense_attachments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/expense_attachments").should route_to("expense_attachments#create")
    end

    it "routes to #update" do
      put("/expense_attachments/1").should route_to("expense_attachments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/expense_attachments/1").should route_to("expense_attachments#destroy", :id => "1")
    end

  end
end
