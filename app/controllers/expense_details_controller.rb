class ExpenseDetailsController < ApplicationController
  load_and_authorize_resource

  # GET /expense_details
  # GET /expense_details.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_details }
    end
  end

  # GET /expense_details/1
  # GET /expense_details/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_detail }
    end
  end

  # GET /expense_details/new
  # GET /expense_details/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_detail }
    end
  end

  # GET /expense_details/1/edit
  def edit
  end

  # POST /expense_details
  # POST /expense_details.json
  def create
    respond_to do |format|
      if @expense_detail.save
        format.html { redirect_to expense_details_path, notice: "Expense detail '#{@expense_detail.name}' was successfully created." }
        format.json { render json: @expense_detail, status: :created, location: @expense_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @expense_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expense_details/1
  # PUT /expense_details/1.json
  def update
    respond_to do |format|
      if @expense_detail.update_attributes(params[:expense_detail])
        format.html { redirect_to expense_details_path, notice: "Expense detail '#{@expense_detail.name}' was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_details/1
  # DELETE /expense_details/1.json
  def destroy
    @expense_detail.destroy

    respond_to do |format|
      format.html { redirect_to expense_details_path, notice: "Expense detail '#{@expense_detail.name}' was successfully deleted." } }
      format.json { head :no_content }
    end
  end
end
