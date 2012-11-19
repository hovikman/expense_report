class CurrenciesDatatable < Datatable 

  def data
    items.map do |currency|
      [
        currency.id,
        currency.code,
        currency.name
      ]
    end
  end
  
  def columns
    %w[id code name]
  end

  def search_cols
    ['currencies.code', 'currencies.name']
  end

end