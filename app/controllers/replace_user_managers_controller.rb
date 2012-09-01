class ReplaceUserManagersController < ApplicationController
  def new
    @replace_user_manager = ReplaceUserManager.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @replace_user_manager = ReplaceUserManager.new(params[:replace_user_manager])
    if @replace_user_manager.valid?
      manager_id     = @replace_user_manager.manager_id
      new_manager_id = @replace_user_manager.new_manager_id
      success_num = 0
      failure_num = 0
      User.where("manager_id = ?", manager_id).each do |user|
        if user.update_attribute(:manager_id, new_manager_id)
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
      elsif failure_num == 0
        notification = "No users have been updated."
      else
        notification = "#{failure_num} user(s) have failed."
      end
      redirect_to new_replace_user_manager_path, notice: notification
    else # not valid
      render :action => 'new'
    end
  end

end