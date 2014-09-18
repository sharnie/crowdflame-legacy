class RemoveUserIdFromOffers < ActiveRecord::Migration
  def change
    remove_column :offers, :user_id, :integer
  end
end
