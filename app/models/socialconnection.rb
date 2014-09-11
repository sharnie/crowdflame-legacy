class Socialconnection < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :user_id, :uid, :provider
  validates :uid, :uniqueness => {:scope => [:provider]}

  default_scope { order('created_at DESC') }

  def self.instagram_auth user, client
    user.socialconnections.create(uid: client["id"], provider: "instagram") do |connection|
      connection.followers       = client.counts.followed_by
      connection.following       = client.counts.follows
      connection.media_count     = client.counts.media
      connection.bio             = client.bio
      connection.profile_picture = client.profile_picture
      connection.username        = client.username
      connection.access_token    = client.access_token
    end
  end

  def self.provider provider_name
    Socialconnection.find_by(provider: provider_name)
  end

end