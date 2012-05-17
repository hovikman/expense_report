require 'test_helper'
require 'attribute-defaults'

class ExpensesControllerTest < ActionController::TestCase
  setup do
    @expense = expenses(:one)
    @expense2 = expenses(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense" do
    assert_difference('Expense.count') do
      post :create, expense: { advance_pay: @expense.advance_pay, expense_status_id: @expense.expense_status_id, purpose: @expense.purpose, submit_date: @expense.submit_date, user_id: @expense.user_id }
    end

    assert_redirected_to expense_path(assigns(:expense))
  end

  test "should show expense" do
    get :show, id: @expense
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense
    assert_response :success
  end

  test "should update expense" do
    put :update, id: @expense, expense: { advance_pay: @expense.advance_pay, expense_status_id: @expense.expense_status_id, purpose: @expense.purpose, submit_date: @expense.submit_date, user_id: @expense.user_id }
    assert_redirected_to expense_path(assigns(:expense))
  end

  test "should destroy expense" do
    assert_difference('Expense.count', -1) do
      delete :destroy, id: @expense2
    end

    assert_redirected_to expenses_path
  end
end
