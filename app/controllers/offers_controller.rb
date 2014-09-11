class OffersController < ApplicationController
  before_action :validate_socialconnections, only: [:new]
  before_action :find_connection, only: [:create]

  def index
    @offers = Offer.all
    # binding.pry
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer          = current_user.offers.create(offer_params)
    @offer.title    = @offer.title.squish
    @offer.price    = 5

    @offer.socialconnection = @connection
    @offer.category         = @offer.socialconnection.category

    if @offer.save
      redirect_to offers_path, notice: "Your offer was created successfully!"
    else
      render new_offer_path
    end
  end

  private
    def offer_params
      params.require(:offer).permit(:title, :description, :delivery, :instructions)
    end

    def validate_socialconnections
      if !current_user.have_connections?
        redirect_to socialconnections_path, notice: "Please make at least 1 connection before making an offer"
      elsif current_user.incomplete_connections.count > 0
        redirect_to socialconnections_path, notice: "Please update @#{current_user.incomplete_connections.first.keys.first} information before making an offer"
      end
    end

    def find_connection
      @connection = current_user.socialconnections.find(params[:socialconnection][:id])
    end
end