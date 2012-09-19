class UserTypesController < ApplicationController
  load_and_authorize_resource

  # GET /user_types
  # GET /user_types.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_types }
    end
  end

  # GET /user_types/1
  # GET /user_types/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_type }
    end
  end

  # GET /user_types/new
  # GET /user_types/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_type }
    end
  end

  # GET /user_types/1/edit
  def edit
  end

  # POST /user_types
  # POST /user_types.json
  def create
    respond_to do |format|
      if @user_type.save
        format.html { redirect_to user_types_path, flash: { success: "User type '#{@user_type.name}' was successfully created." } }
        format.json { render json: @user_type, status: :created, location: @user_type }
      else
        format.html { render action: "new" }
        format.json { render json: @user_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_types/1
  # PUT /user_types/1.json
  def update
    respond_to do |format|
      if @user_type.update_attributes(params[:user_type])
        format.html { redirect_to user_types_path, flash: { success: "User type '#{@user_type.name}' was successfully updated." } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_types/1
  # DELETE /user_types/1.json
  def destroy
    begin
      @user_type.destroy
      notification = "User type '#{@user_type.name}' was successfully deleted."
      flash_status = :success
    rescue Exception => e
      notification = e.message
      flash_success = :error
    end

    respond_to do |format|
        format.html { redirect_to user_types_path, flash: { flash_status => notification } }
      format.json { head :no_content }
    end
  end
end
