class HotelsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :top5, :show]
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :hotel_creator, only: [:edit, :update, :destroy]

  def index
    @hotels = Hotel.all
  end

  def top5
    @hotels = Hotel.order('average_rate DESC').take(5)
  end

  def show
  end

  def new
    @hotel = current_user.hotels.new
  end

  def edit
  end

  def create
    @hotel = current_user.hotels.new(hotel_params)
    if @hotel.save
      redirect_to @hotel, notice: 'Hotel was successfully created.'
    else
      render :new
    end
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to @hotel, notice: 'Hotel was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    redirect_to hotels_url, notice: 'Hotel was successfully destroyed.'
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_creator
    unless @hotel.user == current_user
      redirect_to hotels_url, notice: 'You have no permission for it!'
    end
  end

  def hotel_params
    params.require(:hotel).permit(:title, :breakfast, :room_description, :price_decimal, :price_currency, :score, :photo, address_attributes: [:address, :address_ii, :city, :state, :country_alpha2], rates_attributes: [[:id, :rate, :user_id, :hotel_id]])
  end
end
