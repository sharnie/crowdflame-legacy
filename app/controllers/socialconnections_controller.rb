class SocialconnectionsController < ApplicationController
  before_action :find_connection, only: [:update, :destroy, :refresh_connection]
  before_action :find_category,   only: [:create, :update]

  def index
    @socialconnections = current_user.socialconnections.order('updated_at DESC')
  end

  def new
    @socialconnection = Socialconnection.new
  end

  def create
    @socialconnection = Socialconnection.create_connection(current_user, connection_params, session[:connection])
    @socialconnection.category_id = @category.id

    if @socialconnection.save
      session[:connection].clear
      redirect_to socialconnections_path, notice: "Successfully created connection"
    else
      redirect_to socialconnections_path, notice: @socialconnection.errors.full_messages
    end
  end

  def update
    @connection.update_attributes(connection_params)
    @connection.category = @category

    if @connection.save
      redirect_to socialconnections_path, notice: "Your connection has been updated. Start making offers!"
    else
      redirect_to socialconnections_path, error: "Please try again."
    end
  end

  def destroy
    @connection.destroy
    redirect_to socialconnections_path
  end

  def clear_connection
    session[:connection].clear
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

    def find_connection
      @connection = current_user.socialconnections.find(params[:id])
      redirect_to root_path, error: "Unauthorize action." if @connection.blank?
    end

    def find_category
      @category = Category.find(params[:socialconnection][:category])
      redirect_to socialconnections_path, notice: "Could not find category" if @category.blank?
    end
end