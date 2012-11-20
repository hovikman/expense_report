class CompaniesController < ApplicationController
  load_and_authorize_resource

  # GET /companies
  # GET /companies.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: CompaniesDatatable.new(view_context, @companies) }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_path, flash: { success: "Company '#{@company.name}' was successfully created."} }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to companies_path, flash: { success: "Company '#{@company.name}' was successfully updated."} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    begin
      @company.destroy
      notification = "Company '#{@company.name}' was successfully deleted."
      flash_status = :success
    rescue Exception => e
      notification = e.message
      flash_status = :error
    end

    respond_to do |format|
      format.html { redirect_to companies_path, flash: { flash_status => notification } }
      format.json { head :no_content }
    end
  end
end
