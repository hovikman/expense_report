class CompaniesDatatable < Datatable 
  delegate :number_to_phone, to: :@view

  def data
    items.map do |company|
      [
        company.id,
        company.name,
        company.contact_person,
        company.contact_title,
        number_to_phone(company.contact_phone, area_code: true)
      ]
    end
  end
  
  def columns
    %w[id name contact_person contact_title contact_phone]
  end

  def search_cols
    ['companies.name', 'companies.contact_person', 'companies.contact_title']
  end

end