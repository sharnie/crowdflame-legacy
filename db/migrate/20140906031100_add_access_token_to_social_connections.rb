class AddAccessTokenToSocialConnections < ActiveRecord::Migration
  def change
    add_column :socialconnections, :access_token, :text
  end
end
