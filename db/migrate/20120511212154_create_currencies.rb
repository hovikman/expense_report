class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name, :limit => 30, :null => false
      t.string :code, :limit => 3, :null => false

      t.timestamps
    end
  end
end
