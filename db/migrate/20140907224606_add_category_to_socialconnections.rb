class AddCategoryToSocialconnections < ActiveRecord::Migration
  def change
    add_column :socialconnections, :category_id, :text
  end
end
