require 'test_helper'

class ExpenseDetailsControllerTest < ActionController::TestCase
  setup do
    @expense_detail = expense_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_detail" do
    assert_difference('ExpenseDetail.count') do
      post :create, expense_detail: { amount: @expense_detail.amount, comments: @expense_detail.comments, currency_id: @expense_detail.currency_id, date: @expense_detail.date, exchange_rate: @expense_detail.exchange_rate, expense_id: @expense_detail.expense_id, expense_type_id: @expense_detail.expense_type_id }
    end

    assert_redirected_to expense_detail_path(assigns(:expense_detail))
  end

  test "should show expense_detail" do
    get :show, id: @expense_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @expense_detail
    assert_response :success
  end

  test "should update expense_detail" do
    put :update, id: @expense_detail, expense_detail: { amount: @expense_detail.amount, comments: @expense_detail.comments, currency_id: @expense_detail.currency_id, date: @expense_detail.date, exchange_rate: @expense_detail.exchange_rate, expense_id: @expense_detail.expense_id, expense_type_id: @expense_detail.expense_type_id }
    assert_redirected_to expense_detail_path(assigns(:expense_detail))
  end

  test "should destroy expense_detail" do
    assert_difference('ExpenseDetail.count', -1) do
      delete :destroy, id: @expense_detail
    end

    assert_redirected_to expense_details_path
  end
end
