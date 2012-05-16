class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :company_id, :null => false
      t.string :name, :limit => 30, :null => false
      t.integer :manager_id
      t.string :email, :limit => 40, :null => false
      t.integer :user_type_id, :null => false

      t.timestamps
    end
  end
end
