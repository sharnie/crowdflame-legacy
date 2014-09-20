class SocialConnectionUrl
  def self.authorize provider
    case provider
    when "instagram"
      Instagram.authorize_url(redirect_uri: ENV['INSTAGRAM_REDIRECT_URI'])
    end
  end

  def self.callback provider, code=nil
    case provider
    when "instagram"
      response = Instagram.get_access_token(code, redirect_uri: ENV['INSTAGRAM_REDIRECT_URI'])
      client   = Instagram.client(access_token: response.access_token)
      client.user.merge(access_token: response.access_token, provider: provider)
    end
  end

  # def self.update_connection connection
  #   user = Instagram.client(access_token: connection.access_token).user
  #   connection.tap do |attribute|
  #     attribute.uid             = user.id
  #     attribute.followers       = user.counts.followed_by
  #     attribute.following       = user.counts.follows
  #     attribute.media_count     = user.counts.media
  #     attribute.profile_picture = user.profile_picture
  #     attribute.access_token    = user.access_token
  #     attribute.username        = user.username
  #     attribute.bio             = user.bio
  #   end
  #   connection.save
  # end
end