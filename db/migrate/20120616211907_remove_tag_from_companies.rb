class RemoveTagFromCompanies < ActiveRecord::Migration
  def up
    remove_column :companies, :tag
  end

  def down
    add_column :companies, :tag, :string
  end
end
