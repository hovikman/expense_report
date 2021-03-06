class UsersController < ApplicationController
  load_and_authorize_resource
  
  # GET /users
  # GET /users.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: UsersDatatable.new(view_context, @users.for_datatable) }

    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|
      if @user.save
        Notifier.welcome(@user).deliver
        format.html { redirect_to users_path, flash: { success: "User '#{@user.name}' was successfully created." } }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, flash: { success: "User '#{@user.name}' was successfully updated." } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user.destroy
      notification = "User '#{@user.name}' was successfully deleted."
      flash_status = :success
    rescue Exception => e
      notification = e.message
      flash_status = :error
    end
    respond_to do |format|
      format.html { redirect_to users_path, flash: { flash_status => notification } }
      format.json { head :no_content }
    end
  end

end
