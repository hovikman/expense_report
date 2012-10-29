class ExpenseAttachmentsDatatable
  delegate :params, to: :@view

  def initialize(view, expense_attachment_list)
    @view = view
    @expense_attachment_list = expense_attachment_list
  end

  def as_json(options = {})
    {
      aaData: data,
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @expense_attachment_list.count,
      iTotalDisplayRecords: @display_records
    }
  end

private

  def data
    expense_attachments.map do |expense_attachment|
      [
        expense_attachment.id,
        expense_attachment.description
      ]
    end
  end

  def expense_attachments
    @expense_attachments ||= fetch_expense_attachments
  end

  def fetch_expense_attachments
    expense_attachments = @expense_attachment_list
    if params[:sSearch].present?
      expense_attachments = expense_attachments.where("description like :search", search: "%#{params[:sSearch]}%")
    end
    @display_records = expense_attachments.count
    expense_attachments = expense_attachments.order("#{sort_column} #{sort_direction}")
    expense_attachments = expense_attachments.page(page).per(per_page)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id description]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end