class RemoveUserColumns < ActiveRecord::Migration
  def change
    remove_column :users, :profile_picture, :text
    remove_column :users, :instagram_id,    :integer
  end
end
