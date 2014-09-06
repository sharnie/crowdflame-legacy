class CreateSocialconnections < ActiveRecord::Migration
  def change
    create_table :socialconnections do |t|
      t.integer  :user_id
      t.string   :uid
      t.string   :provider
      t.text     :profile_picture
      t.integer  :followers
      t.integer  :following
      t.integer  :media_count
      t.string   :bio

      t.timestamps
    end
  end
end
