class ExpenseStatusesController < ApplicationController
  # GET /expense_statuses
  # GET /expense_statuses.json
  def index
    @expense_statuses = ExpenseStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_statuses }
    end
  end

  # GET /expense_statuses/1
  # GET /expense_statuses/1.json
  def show
    @expense_status = ExpenseStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_status }
    end
  end

  # GET /expense_statuses/new
  # GET /expense_statuses/new.json
  def new
    @expense_status = ExpenseStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_status }
    end
  end

  # GET /expense_statuses/1/edit
  def edit
    @expense_status = ExpenseStatus.find(params[:id])
  end

  # POST /expense_statuses
  # POST /expense_statuses.json
  def create
    @expense_status = ExpenseStatus.new(params[:expense_status])

    respond_to do |format|
      if @expense_status.save
        format.html { redirect_to @expense_status, notice: 'Expense status was successfully created.' }
        format.json { render json: @expense_status, status: :created, location: @expense_status }
      else
        format.html { render action: "new" }
        format.json { render json: @expense_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expense_statuses/1
  # PUT /expense_statuses/1.json
  def update
    @expense_status = ExpenseStatus.find(params[:id])

    respond_to do |format|
      if @expense_status.update_attributes(params[:expense_status])
        format.html { redirect_to @expense_status, notice: 'Expense status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_statuses/1
  # DELETE /expense_statuses/1.json
  def destroy
    @expense_status = ExpenseStatus.find(params[:id])
    @expense_status.destroy

    respond_to do |format|
      format.html { redirect_to expense_statuses_url }
      format.json { head :no_content }
    end
  end
end
