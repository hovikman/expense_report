class ExpenseTypesController < ApplicationController
  # GET /expense_types
  # GET /expense_types.json
  def index
    @expense_types = ExpenseType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_types }
    end
  end

  # GET /expense_types/1
  # GET /expense_types/1.json
  def show
    @expense_type = ExpenseType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_type }
    end
  end

  # GET /expense_types/new
  # GET /expense_types/new.json
  def new
    @expense_type = ExpenseType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_type }
    end
  end

  # GET /expense_types/1/edit
  def edit
    @expense_type = ExpenseType.find(params[:id])
  end

  # POST /expense_types
  # POST /expense_types.json
  def create
    @expense_type = ExpenseType.new(params[:expense_type])

    respond_to do |format|
      if @expense_type.save
        format.html { redirect_to @expense_type, notice: 'Expense type was successfully created.' }
        format.json { render json: @expense_type, status: :created, location: @expense_type }
      else
        format.html { render action: "new" }
        format.json { render json: @expense_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expense_types/1
  # PUT /expense_types/1.json
  def update
    @expense_type = ExpenseType.find(params[:id])

    respond_to do |format|
      if @expense_type.update_attributes(params[:expense_type])
        format.html { redirect_to @expense_type, notice: 'Expense type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_types/1
  # DELETE /expense_types/1.json
  def destroy
    @expense_type = ExpenseType.find(params[:id])
    @expense_type.destroy

    respond_to do |format|
      format.html { redirect_to expense_types_url }
      format.json { head :no_content }
    end
  end
end
