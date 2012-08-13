class ExpensesController < ApplicationController
  load_and_authorize_resource

  # GET /expenses
  # GET /expenses.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  def to_approve_index
    users = User.where("manager_id = #{current_user.id}").map {|user| user.id }
    user_ids = '(' + users.join(', ') +')'
    @expenses = Expense.where("(expense_status_id = #{ExpenseStatus.assigned_to_manager_id}) and (user_id IN #{user_ids})")
    
    respond_to do |format|
      format.html # to_approve_index.html.erb
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
        format.html { redirect_to expenses_path, notice: "Expense '#{@expense.purpose}' was successfully created." }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to expenses_path, notice: "Expense '#{@expense.purpose}' was successfully updated." }
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
      notification = "User '#{@expense.name}' was successfully deleted."
    rescue Exception => e
      notification = e.message
    end
    respond_to do |format|
      format.html { redirect_to expenses_path, notice: "#{notification}" }
      format.json { head :no_content }
    end
  end
end
