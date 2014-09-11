class AddSocialconnectionToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :socialconnection_id, :integer
  end
end
