class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, :limit => 30, :null => false
      t.string :tag, :limit => 15, :null => false
      t.integer :currency_id, :null => false
      t.string :contact_person, :limit => 30, :null => false
      t.string :contact_title, :limit => 20, :null => false
      t.string :contact_phone, :limit => 20, :null => false
      t.string :contact_email, :limit => 40, :null => false

      t.timestamps
    end
  end
end
