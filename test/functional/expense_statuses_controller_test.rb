require 'test_helper'

class ExpenseStatusesControllerTest < ActionController::TestCase
  setup do
    @expense_status = expense_statuses(:one)
    @update = {
      :name => 'New Expense Status'
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_status" do
    assert_difference('ExpenseStatus.count') do
      post :create, :expense_status => @update
    end

    assert_redirected_to expense_status_path(assigns(:expense_status))
  end

  test "should show expense_status" do
    get :show, id: @expense_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_status
    assert_response :success
  end

  test "should update expense_status" do
    put :update, :id =>  @expense_status.to_param, :expense_status => @update
    assert_redirected_to expense_status_path(assigns(:expense_status))
  end

  test "should destroy expense_status" do
    assert_difference('ExpenseStatus.count', -1) do
      delete :destroy, id: @expense_status
    end

    assert_redirected_to expense_statuses_path
  end
end
