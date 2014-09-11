class SocialConnectionUrl
  def self.authorize provider
    case provider
    when "instagram"
      Instagram.authorize_url(redirect_uri: ENV['INSTAGRAM_REDIRECT_URI'])
    end
  end

  def self.callback provider, code=nil, user
    case provider
    when "instagram"
      response = Instagram.get_access_token(code, redirect_uri: ENV['INSTAGRAM_REDIRECT_URI'])
      client   = Instagram.client(access_token: response.access_token)
      Socialconnection.instagram_auth(user, client.user.merge(access_token: response.access_token))
    end
  end
end