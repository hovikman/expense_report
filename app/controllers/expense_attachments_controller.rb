class ExpenseAttachmentsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:expense_id] == '0'
      @expense = Expense.new()
    else
      @expense = Expense.find(params[:expense_id])
    end
    @expense_attachments = @expense.expense_attachments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: ExpenseAttachmentsDatatable.new(view_context, @expense_attachments) }
    end
  end

  def show
    @expense_attachment = ExpenseAttachment.find(params[:id])
    send_file(@expense_attachment.file_path.current_path)
  end

  def new
    @expense_attachment = ExpenseAttachment.new(:expense_id => params[:expense_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense_attachment }
    end
  end

  def edit
    @expense_attachment = ExpenseAttachment.find(params[:id])
  end

  def create
    @expense_attachment = ExpenseAttachment.new(params[:expense_attachment])

    if params[:save_and_exit_button]
      # save_and_exit_button was pressed
      redirect_path = get_expense_list_path + '#tab_attachments'
    else
      # save_and_create_more_button was pressed
      redirect_path = new_expense_expense_attachment_path(params[:expense_id])
    end
 
    respond_to do |format|
      if @expense_attachment.save
        format.html { redirect_to redirect_path, flash: { success: "Expense attachment '#{@expense_attachment.description}' was successfully created." } }
        format.json { render json: @expense_attachment, status: :created, location: @expense_attachment }
      else
        format.html { render action: "new" }
        format.json { render json: @expense_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @expense_attachment = ExpenseAttachment.find(params[:id])

    respond_to do |format|
      if @expense_attachment.update_attributes(params[:expense_attachment])
        format.html { redirect_to get_expense_list_path + '#tab_attachments',
                      flash: { success: "Expense attachment '#{@expense_attachment.description}' was successfully updated." }
                    }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @expense_attachment.destroy
      notification = "Expense attachment '#{@expense_attachment.description}' was successfully deleted."
      flash_status = :success
    rescue Exception => e
      notification = e.message
      flash_status = :error
    end

    respond_to do |format|
      format.html { redirect_to get_expense_list_path + '#tab_attachments', flash: { flash_status => notification } }
      format.json { head :no_content }
    end
  end
end