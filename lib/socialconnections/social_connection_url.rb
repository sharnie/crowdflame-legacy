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
end