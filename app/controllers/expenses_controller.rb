class ExpensesController < ApplicationController
  load_and_authorize_resource

  # GET /expenses
  # GET /expenses.json
  def index
    respond_to do |format|
      format.html { render template: 'expenses/index.html.erb', locals: { title: 'Listing Expenses' } }
      format.json { render json: @expenses }
    end
  end

  def owned
    respond_to do |format|
      format.html { render template: 'expenses/index.html.erb', locals: { title: 'Listing Owned Expenses' } }
      format.json { render json: @expenses }
    end
  end
  
  def submitted
    respond_to do |format|
      format.html { render template: 'expenses/index.html.erb', locals: { title: 'Listing Submitted Expenses' } }
      format.json { render json: @expenses }
    end
  end  

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_expense_details_path(@expense.id), flash: { success: "Expense '#{@expense.purpose}' was successfully created." } }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_state
    if params[:send_for_approval_from_new_button]
      if @expense.user.manager_id
        @expense.expense_status_id = ExpenseStatus.assigned_to_manager_id
        @expense.owner_id          = @expense.user.manager_id
        transition_name            = "sent to manager"
      else
        @expense.expense_status_id = ExpenseStatus.assigned_to_accounting_id  
        @expense.owner_id          = @expense.user.company.accountant_id
        transition_name            = "sent to accounting"
      end                
    elsif params[:reject_from_assigned_to_manager_button]
      @expense.expense_status_id = ExpenseStatus.new_id
      @expense.owner_id          = @expense.user_id
      transition_name            = "rejected"
    elsif params[:approve_from_assigned_to_manager_button]
      @expense.expense_status_id = ExpenseStatus.assigned_to_accounting_id
      @expense.owner_id          = @expense.user.company.accountant_id
      transition_name            = "approved"
    elsif params[:reject_from_assigned_to_accounting_button]
      @expense.expense_status_id = ExpenseStatus.new_id
      @expense.owner_id          = @expense.user_id
      transition_name            = "rejected"
    elsif params[:approve_from_assigned_to_accounting_button]
      @expense.expense_status_id = ExpenseStatus.approved_id
      @expense.owner_id          = nil
      transition_name            = "approved"
    end
    
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        Notifier.became_owner(@expense).deliver if @expense.owner_id?
        Notifier.status_changed(@expense).deliver
        format.html { redirect_to  owned_expenses_path, flash: { success: "Expense '#{@expense.purpose}' was successfully #{transition_name}." } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        Notifier.became_owner(@expense).deliver if (@expense.owner_id_changed?) and (@expense.owner_id?)
        Notifier.status_changed(@expense).deliver if @expense.expense_status_id_changed?
                        
        format.html { redirect_to expenses_path, flash: { success: "Expense '#{@expense.purpose}' was successfully updated." } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    begin
      @expense.destroy
      notification = "Expense '#{@expense.purpose}' was successfully deleted."
      flash_status = :success
    rescue Exception => e
      notification = e.message
      flash_status = :error
    end
    respond_to do |format|
      format.html { redirect_to expenses_path, flash: { flash_status => notification } }
      format.json { head :no_content }
    end
  end
  
end
