class SocialconnectionsController < ApplicationController
  before_action :correct_user, only: [:update, :destroy]
  before_action :connection_category, only: [:create]

  def index
    @socialconnections = current_user.socialconnections
  end

  def new
    @socialconnection = Socialconnection.new
  end

# {"username"=>"mbamg",
#  "bio"=>
#   "Welcome to the official Instagram channel for AMG Fans. Tag @MBAMG in your photos/videos.",
#  "website"=>"http://mercedes-amg.com",
#  "profile_picture"=>
#   "http://images.ak.instagram.com/profiles/profile_511046930_75sq_1376772056.jpg",
#  "full_name"=>"MERCEDES ///AMG",
#  "counts"=>{"media"=>34, "followed_by"=>799, "follows"=>40},
#  "id"=>"511046930",
#  "access_token"=>"511046930.b0e2f63.3c58c2aa77ad427b836621bde731334b",
#  "provider"=>"instagram"}

  def create
    @socialconnection = current_user.socialconnections.create(connection_params) do |connection|
      connection.category_id     = @category.id
      connection.provider        = session[:connection]['provider']
      connection.uid             = session[:connection]['id']
      connection.followers       = session[:connection]['counts']['followed_by']
      connection.following       = session[:connection]['counts']['follows']
      connection.media_count     = session[:connection]['counts']['media']
      connection.profile_picture = session[:connection]['profile_picture']
      connection.access_token    = session[:connection]['access_token']
      connection.username        = session[:connection]['username']
      connection.bio             = session[:connection]['bio']
    end

    if @socialconnection.save
      session[:connection].clear
      redirect_to socialconnections_path, notice: "Successfully created connection"
    else
      redirect_to socialconnections_path, notice: @socialconnection.errors.full_messages
    end
  end

  def update
    @connection.update_attributes(connection_params)

    category = Category.find_by(params[:category])
    if !category.blank?
      @connection.category = category
      @connection.topic    = category.name 
      @connection.save
      redirect_to socialconnections_path, notice: "Your connection has been updated. Start making offers!"
    else
      redirect_to socialconnections_path
      flash[:error] = "Don't forget to choose a topic for @#{@connection.username}!"
    end
  end

  def destroy
    @connection.destroy
    redirect_to socialconnections_path
  end

  def connect
    redirect_to SocialConnectionUrl.authorize(params[:provider])
  end

  def callback
    session[:connection].clear
    connection = SocialConnectionUrl.callback("instagram", params[:code])
    if Socialconnection.find_by(uid: connection.id)
      flash[:error] = "Instagram account is already taken. Please try again!" 
    else
      session[:connection] = connection
    end
  end

  private

    def connection_params
      params.require(:socialconnection).permit(:topic, :tags, :language, :age)
    end

    def correct_user
      @connection = current_user.socialconnections.find(params[:id])
      redirect_to root_path, error: "Unauthorize action." if @connection.nil?
    end

    def connection_category
      @category = Category.find(params[:socialconnection][:category])
      if @category.blank?
        redirect_to socialconnections_path, notice: "Could not find category"
      else
        @category
      end
    end
end