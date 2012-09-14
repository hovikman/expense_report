class ExpenseTypesController < ApplicationController
  load_and_authorize_resource

  # GET /expense_types
  # GET /expense_types.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expense_types }
    end
  end

  # GET /expense_types/1
  # GET /expense_types/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense_type }
    end
  end

  # GET /expense_types/new
  # GET /expense_types/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_type }
    end
  end

  # GET /expense_types/1/edit
  def edit
  end

  # POST /expense_types
  # POST /expense_types.json
  def create
    respond_to do |format|
      if @expense_type.save
        format.html { redirect_to expense_types_path, notice: "Expense detail '#{@expense_type.name}' was successfully created." }
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
    respond_to do |format|
      if @expense_type.update_attributes(params[:expense_type])
        format.html { redirect_to expense_types_path, notice: "Expense detail '#{@expense_type.name}' was successfully updated." }
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
    begin
      @expense_type.destroy
      notification = "Expense type '#{@expense_type.name}' was successfully deleted."
    rescue Exception => e
      notification = e.message
    end

    respond_to do |format|
      format.html { redirect_to expense_types_path, notice: "#{notification}" }
      format.json { head :no_content }
    end
  end
end
