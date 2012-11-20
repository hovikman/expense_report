class ExpenseTypesDatatable < Datatable 
  def data
    items.map do |expense_type|
      [
        expense_type.id,
        expense_type.name,
        expense_type.company_name
      ]
    end
  end
  
  def columns
    %w[id name company_name]
  end

  def search_cols
    ['expense_types.name', 'companies.name']
  end

end