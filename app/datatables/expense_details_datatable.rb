class ExpenseDetailsDatatable < Datatable 
  delegate :number_to_currency, to: :@view

  def data
    items.map do |expense_detail|
      [
        expense_detail.id,
        expense_detail.date.strftime("%B %e, %Y"),
        expense_detail.type_name,
        number_to_currency(expense_detail.total_amount, precision: 2, delimiter: "", format: "%n")
      ]
    end
  end
  
  def columns
    %w[id date type_name total_amount]
  end

  def search_cols
    ['expense_types.name']
  end
  
end