class ExpenseDetailsDatatable
  delegate :params, :number_to_currency, to: :@view

  def initialize(view, expense_detail_list)
    @view = view
    @expense_detail_list = expense_detail_list
  end

  def as_json(options = {})
    {
      aaData: data,
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @expense_detail_list.count,
      iTotalDisplayRecords: @display_records
    }
  end

private

  def data
    expense_details.map do |expense_detail|
      [
        expense_detail.id,
        expense_detail.date.strftime("%B %e, %Y"),
        expense_detail.expense_type.name,
        number_to_currency(expense_detail.total_amount(), precision: 2, delimiter: "", format: "%n")
      ]
    end
  end

  def expense_details
    @expense_details ||= fetch_expense_details
  end

  def fetch_expense_details
    expense_details = @expense_detail_list
    if params[:sSearch].present?
      # expense_details = expense_details.where("description like :search", search: "%#{params[:sSearch]}%")
    end
    @display_records = expense_details.count
    expense_details = ordered_expense_details(expense_details)
    expense_details = Kaminari.paginate_array(expense_details).page(page).per(per_page)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def ordered_expense_details(expense_details)
    field_index = params[:iSortCol_0].to_i
    if field_index == 1
      # sort by date
      expense_details.order("date #{sort_direction}")
    elsif field_index == 2
      # sort by expense_type.name
      expense_details.joins(:expense_type).order("expense_types.name #{sort_direction}")
    elsif field_index == 3
      # sort by total_amount
      if sort_direction == 'asc'
        expense_details.sort_by { |exp_detail| exp_detail.total_amount() }
      else
        expense_details.sort_by { |exp_detail| exp_detail.total_amount() }.reverse
      end
    end
  end
  
  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end