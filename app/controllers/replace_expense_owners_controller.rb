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
      owner_id     = @replace_expense_owner.owner_id
      new_owner_id = @replace_expense_owner.new_owner_id

      success_num = 0
      failure_num = 0
      Expense.where({owner_id: owner_id}).each do |expense|
        if expense.update_attribute(:owner_id, new_owner_id)
          Notifier.became_owner(expense).deliver
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
      elsif failure_num == 0
        notification = "No expenses have been updated."
      else
        notification = "#{failure_num} expense(s) have failed."
      end
      redirect_to new_replace_expense_owner_path, notice: notification
    else # not valid
      render :action => 'new'
    end
  end

end