class ExpensesDatatable < Datatable 
  delegate :number_to_currency, to: :@view
  def data
    items.map do |expense|
      [
        expense.id,
        expense.user_name,
        expense.submit_date.strftime("%B %e, %Y"),
        expense.purpose,
        expense.status_name,
        number_to_currency(expense.total_amount, precision: 2, delimiter: "", format: "%n")
      ]
    end
  end
  
  def columns
    %w[id user_name submit_date purpose status_name total_amount]
  end

  def search_cols
    ['users.name', 'expenses.purpose', 'expense_statuses.name']
  end

end