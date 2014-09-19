class Socialconnection < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many   :offers

  validates_presence_of :user_id, :uid, :provider, :category
  validates :uid, :uniqueness => {:scope => [:provider]}

  default_scope { order('created_at DESC') }

  def self.instagram_client current_user, connection
    # user.socialconnections.create(uid: client["id"], provider: "instagram") do |connection|
    #   connection.followers       = client.counts.followed_by
    #   connection.following       = client.counts.follows
    #   connection.media_count     = client.counts.media
    #   connection.bio             = client.bio
    #   connection.profile_picture = client.profile_picture
    #   connection.username        = client.username
    #   connection.access_token    = client.access_token
    # end

    # @socialconnection = current_user.socialconnections.create(connection_params) do |connection|
    #   connection.provider = session[:connection]['provider']
    #   connection.uid      = session[:connection]['id']
    #   connection.category = @category

    #   connection.followers       = session[:connection]['counts'].followed_by
    #   connection.following       = client.counts.follows
    #   connection.media_count     = client.counts.media
    #   connection.bio             = client.bio
    #   connection.profile_picture = client.profile_picture
    #   connection.username        = client.username
    #   connection.access_token    = client.access_token
    # end

  end

  def self.provider provider_name
    Socialconnection.find_by(provider: provider_name)
  end

  def self.already_taken?
    !!Socialconnection.find(self.id)
  end

end