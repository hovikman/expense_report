class ExpenseDetailsController < ApplicationController
  load_and_authorize_resource

  def index
    @expense = Expense.find(params[:expense_id])
    @expense_details = @expense.expense_details
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_details }
    end
  end

  def show
    @expense_detail = ExpenseDetail.find(params[:id])
    @expense = Expense.find(@expense_detail.expense_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_detail }
    end
  end

  def new
    @expense = Expense.find(params[:expense_id])
    @expense_detail = @expense.expense_details.build
    @expense_detail.currency_id = Company.find(User.find(@expense.user_id).company_id).currency_id
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_detail }
    end
  end

  def edit
    @expense_detail = ExpenseDetail.find(params[:id])
    @expense = Expense.find(@expense_detail.expense_id)
  end

  def create
    @expense = Expense.find(params[:expense_id])
    @expense_detail = @expense.expense_details.build(params[:expense_detail])
    
    respond_to do |format|
      if @expense_detail.save
        format.html { redirect_to expense_expense_details_path(@expense_detail.expense_id), notice: "Expense detail '#{@expense_detail.expense_type.name}' was successfully created." }
        format.json { render json: @expense_detail, status: :created, location: @expense_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @expense_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @expense_detail = ExpenseDetail.find(params[:id])
    @expense = Expense.find(@expense_detail.expense_id)
    
    respond_to do |format|
      if @expense_detail.update_attributes(params[:expense_detail])
        format.html { redirect_to expense_expense_details_path(@expense_detail.expense_id), notice: "Expense detail '#{@expense_detail.expense_type.name}' was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @expense_detail.destroy
      notification = "Expense detail '#{@expense_detail.expense_type.name}' was successfully deleted."
    rescue Exception => e
      notification = e.message
    end

    respond_to do |format|
      format.html { redirect_to expense_expense_details_path(@expense_detail.expense_id), notice: "#{notification}" }
      format.json { head :no_content }
    end
  end
end
