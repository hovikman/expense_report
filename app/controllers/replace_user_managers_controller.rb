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
      company_id = @replace_user_manager.company_id
      manager_id = @replace_user_manager.manager_id
      if manager_id == ''
        manager_id = nil
      end
      new_manager_id = @replace_user_manager.new_manager_id
      if new_manager_id == ''
        new_manager_id = nil
      end
      success_num = 0
      failure_num = 0
      User.where({company_id: company_id, manager_id: manager_id}).each do |user|
        if user.update_attribute(:manager_id, new_manager_id)
          success_num += 1
        else
          failure_num += 1
        end
      end

      if success_num > 0
        if failure_num == 0
          notification = "#{success_num} user(s) have been succesfully updated."
          flash_status = :success
        else
          notification = "#{success_num} user(s) have been succesfully updated, but #{failure_num} have failed."
          flash_status = :alert
        end
      elsif failure_num == 0
        notification = "No users have been updated."
        flash_stastus = :alert
      else
        notification = "#{failure_num} user(s) have failed."
        flash_status = :error
      end
      redirect_to new_replace_user_manager_path, flash: { flsh_status => notification }
    else # not valid
      render action: 'new'
    end
  end

end