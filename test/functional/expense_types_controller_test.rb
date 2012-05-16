require 'test_helper'

class ExpenseTypesControllerTest < ActionController::TestCase
  setup do
    @expense_type = expense_types(:one)
    @update = {
      :name => 'New Expense Type',
      :company_id => :one
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_type" do
    assert_difference('ExpenseType.count') do
      post :create, :expense_type => @update
    end

    assert_redirected_to expense_type_path(assigns(:expense_type))
  end

  test "should show expense_type" do
    get :show, id: @expense_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_type
    assert_response :success
  end

  test "should update expense_type" do
    put :update, :id => @expense_type.to_param, :expense_type => @update
    assert_redirected_to expense_type_path(assigns(:expense_type))
  end

  test "should destroy expense_type" do
    assert_difference('ExpenseType.count', -1) do
      delete :destroy, id: @expense_type
    end

    assert_redirected_to expense_types_path
  end
end
