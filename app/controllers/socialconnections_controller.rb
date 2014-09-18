class SocialconnectionsController < ApplicationController
  before_action :correct_user, only: [:update, :destroy]

  def index
    @connections = current_user.socialconnections
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
    connection = SocialConnectionUrl.callback("instagram", params[:code], current_user)

    if connection.errors.count > 0
      flash[:error] = "#{connection.errors.full_messages.last.gsub(/(Uid\s)/, "Instagram account ")}. Please try again."
    else
      flash[:notice] = "Connected! Please update @#{connection.username}'s account information to start making offers."
    end
  end

private
  def connection_params
    params.require(:socialconnection).permit(:tags, :language, :age)
  end

  def correct_user
    @connection = current_user.socialconnections.find(params[:id])
    redirect_to root_path, error: "Unauthorize action." if @connection.nil?
  end
end