class RemoveTopicColumnFromSocialconnections < ActiveRecord::Migration
  def change
    remove_column :socialconnections, :topic, :string
  end
end
