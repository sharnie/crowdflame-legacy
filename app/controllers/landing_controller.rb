class LandingController < ApplicationController
  before_action :change_root

  def index
    
  end

private

  def change_root
    redirect_to offers_path if user_signed_in?
  end
end