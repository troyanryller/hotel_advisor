class HotelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :hotel_creator, only: [:edit, :update, :destroy]

  def index
    @hotels = Hotel.all
  end

  def show
  end

  def new
    @hotel = current_user.hotels.new
    @rating = @hotel.ratings.new
  end

  def edit
  end

  def create
    @hotel = current_user.hotels.new(hotel_params)

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      params.require(:hotel).permit(:title, :breakfast, :room_description, :room_price, :photo, rating: [:rate, :comment])
    end
end
