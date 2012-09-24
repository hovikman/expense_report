class AddIndexToUsersPasswordResetToken < ActiveRecord::Migration
  def change
     add_index :users, :password_reset_token, unique: true
 end
end
