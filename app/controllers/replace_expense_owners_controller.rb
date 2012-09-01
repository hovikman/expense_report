class ReplaceExpenseOwnersController < ApplicationController
  def new
    @replace_expense_owner = ReplaceExpenseOwner.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @replace_expense_owner = ReplaceExpenseOwner.new(params[:replace_expense_owner])
    if @replace_expense_owner.valid?
      from_user_id  = @replace_expense_owner.from_user_id
      to_user_id    = @replace_expense_owner.to_user_id

      success_num = 0
      failure_num = 0
      Expense.where("owner_id = ?", from_user_id).each do |expense|
        if expense.update_attribute(:owner_id, to_user_id)
          success_num += 1
        else
          failure_num += 1
        end
      end

      if success_num > 0
        if failure_num == 0
          notification = "#{success_num} expense(s) have been succesfully updated."
        else
          notification = "#{success_num} expense(s) have been succesfully updated, but #{failure_num} have failed."
        end
      else
        if failure_num == 0
          notification = "No expenses have been updated."
        else
          notification = "#{failure_num} expense(s) have failed."
        end
      end
      redirect_to new_replace_expense_owner_path, notice: notification
    else # not valid
      render :action => 'new'
    end
  end

end