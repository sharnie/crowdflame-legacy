class AddInstagramInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider,        :string
    add_column :users, :followers,       :integer
    add_column :users, :following,       :integer
    add_column :users, :media_count,     :integer
    add_column :users, :profile_picture, :text
    add_column :users, :access_token,    :text
    add_column :users, :category_id,     :integer
  end
end
