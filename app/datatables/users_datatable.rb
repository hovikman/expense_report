class UsersDatatable < Datatable 

  def data
    items.map do |user|
      [
        user.id,
        user.name,
        user.company_name,
        user.user_type_name
      ]
    end
  end
  
  def columns
    %w[id name company_name user_type_name]
  end

  def search_cols
    ['users.name', 'companies.name', 'user_types.name']
  end

end