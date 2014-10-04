class InstagramsController < ApplicationController
  def connect
    redirect_to SocialConnectionUrl.authorize(params[:provider])
  end

  def callback
    session[:connection] = SocialConnectionUrl.callback("instagram", params[:code])
    user = User.find_by(uid: session[:connection]['id'].to_i)

    if user.blank?
      redirect_to new_user_registration_path
    else
      sign_in(:user, user)
      redirect_to root_path
    end
  end
end