class OffersController < ApplicationController
  # before_action :validate_socialconnections, only: [:new]
  before_action :find_socialconnection, only: [:create]
  before_action :find_offer, only: [:show]
  before_action :authenticate_user!, except: [:show]

  def index
    @offers = Offer.all
  end

  def show
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = @socialconnection.offers.create(offer_params)
    @offer.title = @offer.title.squish
    @offer.category_id = @socialconnection.category_id

    if @offer.save
      redirect_to offers_path, notice: "Your offer was created successfully!"
    else
      render new_offer_path
    end
  end

  private

    def offer_params
      params.require(:offer).permit(:price, :title, :description, :delivery, :instructions)
    end

    def find_offer
      @offer = Offer.find(params[:id])
    end

    def validate_socialconnections
      if !current_user.have_connections?
        redirect_to socialconnections_path, notice: "Please make at least 1 connection before making an offer"
      elsif current_user.incomplete_connections.count > 0
        account_name = current_user.incomplete_connections.first.keys.first
        missing_field = current_user.incomplete_connections.first[current_user.incomplete_connections.first.keys.first].keys.first
        redirect_to socialconnections_path, notice: "Don't forget to add @#{account_name}'s #{missing_field} information!"
        # "Please update @#{account_name}'s information before making an offer"
      end
    end

    def find_socialconnection
      unless current_user.socialconnections.find(params[:offer][:socialconnection])
        redirect_to root_path, notice: "Could not find social connection!"
      else
        @socialconnection = current_user.socialconnections.find(params[:offer][:socialconnection])
      end
    end
end