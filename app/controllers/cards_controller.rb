class CardsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  if params[:search]
      @cards = Card.where(user_id: current_user).where("title LIKE ?", "%#{params[:search]}%")
      @search_term = params[:search]
    else 
      @cards = Card.where(user_id: current_user)
      @search_term = "";
    end

  end

  def new
  	@card = Card.new
  end

  def create
  	@card = Card.new(card_params)

    @card.user = current_user

  	@card.save
  	redirect_to cards_url
  end

  def show
  	@card = Card.find(params[:id])
  end

  def edit
  	@card = Card.find(params[:id])
  end

  def update
  	@card = Card.find(params[:id])

  	@card.update(card_params)
  	redirect_to cards_url
  end

  def destroy
  	@card = Card.find(params[:id])

  	@card.destroy
  	redirect_to cards_url
  end

  private
  		def card_params
  			params.require(:card).permit(:title, :text)
  		end
end
