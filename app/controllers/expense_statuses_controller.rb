class ExpenseStatusesController < ApplicationController
  load_and_authorize_resource

  # GET /expense_statuses
  # GET /expense_statuses.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_statuses }
    end
  end

  # GET /expense_statuses/1
  # GET /expense_statuses/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_status }
    end
  end

  # GET /expense_statuses/new
  # GET /expense_statuses/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_status }
    end
  end

  # GET /expense_statuses/1/edit
  def edit
  end

  # POST /expense_statuses
  # POST /expense_statuses.json
  def create
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
    @expense_status.destroy

    respond_to do |format|
      format.html { redirect_to expense_statuses_url }
      format.json { head :no_content }
    end
  end
end
