class ExpenseDetailsController < ApplicationController
  # GET /expense_details
  # GET /expense_details.json
  def index
    @expense_details = ExpenseDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_details }
    end
  end

  # GET /expense_details/1
  # GET /expense_details/1.json
  def show
    @expense_detail = ExpenseDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_detail }
    end
  end

  # GET /expense_details/new
  # GET /expense_details/new.json
  def new
    @expense_detail = ExpenseDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_detail }
    end
  end

  # GET /expense_details/1/edit
  def edit
    @expense_detail = ExpenseDetail.find(params[:id])
  end

  # POST /expense_details
  # POST /expense_details.json
  def create
    @expense_detail = ExpenseDetail.new(params[:expense_detail])

    respond_to do |format|
      if @expense_detail.save
        format.html { redirect_to @expense_detail, notice: 'Expense detail was successfully created.' }
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
    @expense_detail = ExpenseDetail.find(params[:id])

    respond_to do |format|
      if @expense_detail.update_attributes(params[:expense_detail])
        format.html { redirect_to @expense_detail, notice: 'Expense detail was successfully updated.' }
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
    @expense_detail = ExpenseDetail.find(params[:id])
    @expense_detail.destroy

    respond_to do |format|
      format.html { redirect_to expense_details_url }
      format.json { head :no_content }
    end
  end
end
