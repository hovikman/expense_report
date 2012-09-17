class ChangeDataTypeForPurpose < ActiveRecord::Migration
  def up
    change_table :expenses do |t|
      t.change :purpose, :string, limit: 40
    end
  end

  def down
    change_table :expenses do |t|
      t.change :purpose, :text
    end
  end
end
