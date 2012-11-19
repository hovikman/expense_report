class ExpenseAttachmentsDatatable < Datatable
  
    def data
    items.map do |expense_attachment|
      [
        expense_attachment.id,
        expense_attachment.description
      ]
    end
  end
  
  def columns
    %w[id description]
  end

  def search_cols
    ['description']
  end
  
end