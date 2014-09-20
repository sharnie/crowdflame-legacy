class Socialconnection < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many   :offers, dependent: :destroy

  validates_presence_of :user_id, :uid, :provider, :category, :tags, :language, :age
  validates :uid, :uniqueness => {:scope => [:provider]}

  default_scope { order('created_at DESC') }

  def self.create_connection current_user, connection_params, instagram_user
    current_user.socialconnections.create(connection_params) do |connection|
      connection.provider        = instagram_user['provider']
      connection.uid             = instagram_user['id']
      connection.followers       = instagram_user['counts']['followed_by']
      connection.following       = instagram_user['counts']['follows']
      connection.media_count     = instagram_user['counts']['media']
      connection.profile_picture = instagram_user['profile_picture']
      connection.access_token    = instagram_user['access_token']
      connection.username        = instagram_user['username']
      connection.bio             = instagram_user['bio']
    end
  end

  def self.provider provider_name
    Socialconnection.find_by(provider: provider_name)
  end

end