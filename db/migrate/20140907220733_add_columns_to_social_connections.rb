class AddColumnsToSocialConnections < ActiveRecord::Migration
  def change
    add_column :socialconnections, :topic, :string
    add_column :socialconnections, :tags, :string
    add_column :socialconnections, :age, :string
    add_column :socialconnections, :language, :string
  end
end
