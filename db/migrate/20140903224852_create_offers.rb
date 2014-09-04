class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer  :user_id
      t.string   :title
      t.string   :description
      t.string   :instructions
      t.integer  :delivery
      t.integer  :price

      t.timestamps
    end
  end
end