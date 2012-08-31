class UsersController < ApplicationController
  load_and_authorize_resource
  
  # GET /users
  # GET /users.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
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
        format.html { redirect_to users_path, notice: "User '#{@user.name}' was successfully created." }
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
        format.html { redirect_to users_path, notice: "User '#{@user.name}' was successfully updated." }
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
    rescue Exception => e
      notification = e.message
    end
    respond_to do |format|
      format.html { redirect_to users_path, notice: "#{notification}" }
      format.json { head :no_content }
    end
  end
  
  def replace_manager_screen
    respond_to do |format|
      format.html # replace_manager_screen.html.erb
    end
  end  

  def replace_manager
    from_user_id  = params[:replace_user_manager_from_user_id]
    to_user_id    = params[:replace_user_manager_to_user_id]
    
    success_num = 0
    failure_num = 0
    User.where("manager_id = ?", from_user_id).each do |user|
      if user.update_attribute(:manager_id, to_user_id)
        success_num += 1
      else
        failure_num += 1
      end
    end
    
    if success_num > 0
      if failure_num == 0
        notification = "#{success_num} user(s) have been succesfully updated."
      else
        notification = "#{success_num} user(s) have been succesfully updated, but #{failure_num} have failed."
      end
    elsif
      if failure_num == 0
        notification = "No users have been updated."
      else
        notification = "#{failure_num} user(s) have failed."
      end
    end
 
    respond_to do |format|
      format.html { redirect_to replace_manager_screen_users_path, notice: notification }
    end
  end

end
