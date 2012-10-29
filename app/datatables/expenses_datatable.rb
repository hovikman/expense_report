class ExpensesDatatable
  delegate :params, :number_to_currency, to: :@view

  def initialize(view, expense_list)
    @view = view
    @expense_list = expense_list
  end

  def as_json(options = {})
    {
      aaData: data,
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @expense_list.count,
      iTotalDisplayRecords: @display_records
    }
  end

private

  def data
    expenses.map do |expense|
      [
        expense.id,
        expense.user.name,
        expense.submit_date.strftime("%B %e, %Y"),
        expense.purpose,
        expense.expense_status.name,
        number_to_currency(expense.total_amount(), precision: 2, delimiter: "", format: "%n")
      ]
    end
  end

  def expenses
    @expenses ||= fetch_expenses
  end

  def fetch_expenses
    expenses = @expense_list
    if params[:sSearch].present?
      expenses = expenses.where("purpose like :search", search: "%#{params[:sSearch]}%")
    end
    @display_records = expenses.count
    expenses = ordered_expenses(expenses)
    expenses = Kaminari.paginate_array(expenses).page(page).per(per_page)
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def ordered_expenses(expenses)
    field_index = params[:iSortCol_0].to_i
    columns = %w[id user submit_date purpose expense_status total_amount]
    if field_index == 1
      # sort by user.name
      expenses.joins(:user).order("users.name #{sort_direction}")
    elsif field_index == 4
      # sort by expense.status
      expenses.joins(:expense_status).order("expense_statuses.name #{sort_direction}")
    elsif field_index == 5
      # sort by total_amount
      if sort_direction == 'asc'
        expenses.sort_by {|exp| exp.total_amount() }
      else
        expenses.sort_by {|exp| exp.total_amount() }.reverse
      end
    else
      expenses.order("#{columns[field_index]} #{sort_direction}")
    end
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end