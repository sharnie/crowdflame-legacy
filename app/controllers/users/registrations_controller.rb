class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super

    if resource.save
      if !session[:connection].blank?
        resource.tap do |user|
          user.provider        = session[:connection]['provider']
          user.uid             = session[:connection]['id']
          user.followers       = session[:connection]['counts']['followed_by']
          user.following       = session[:connection]['counts']['follows']
          user.media_count     = session[:connection]['counts']['media']
          user.profile_picture = session[:connection]['profile_picture']
          user.access_token    = session[:connection]['access_token']
          user.username        = session[:connection]['username']
          user.bio             = session[:connection]['bio']
        end
        resource.save
      else
        resource.destroy!
        return
      end
    end
  end

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      redirect_to after_update_path_for
    else
      render "edit"
    end
  end
  
  private

    def needs_password?(user, params)
      user.email != params[:user][:email] || params[:user][:password].present?
    end

    def after_update_path_for
      edit_user_registration_path
    end

    def after_sign_up_path_for(resource)
      edit_user_registration_path
    end
end