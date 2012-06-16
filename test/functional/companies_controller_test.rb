require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = companies(:one)
    @company2 = companies(:two)
    @update = {
      :name => 'New Company',
      :currency_id => :one,
      :contact_person => 'person',
      :contact_title => 'title',
      :contact_phone => '1234567890',
      :contact_email => 'sample@example.com'
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, :company => @update
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, id: @company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company
    assert_response :success
  end

  test "should update company" do
    put :update, :id => @company.to_param, :company => @update
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete :destroy, id: @company2
    end

    assert_redirected_to companies_path
  end
end
