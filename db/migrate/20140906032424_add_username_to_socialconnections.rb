class AddUsernameToSocialconnections < ActiveRecord::Migration
  def change
    add_column :socialconnections, :username, :string
  end
end
