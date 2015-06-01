class RatesController < ApplicationController
  before_action :set_rate

  def create
    if @rate.update(rate_params)
      redirect_to @rate.hotel, notice: 'Rate successfully added.'
    else
      redirect_to @rate.hotel, alert: 'Invalid data.'
    end
  end

  def update
    if @rate.update(rate_params)
      redirect_to @rate.hotel, notice: 'Rate successfully updated.'
    else
      redirect_to @rate.hotel, alert: 'Invalid data.'
    end
  end

  private

  def set_rate
    @rate = current_user.rates.find_or_initialize_by(hotel_id: params[:hotel_id])
  end

  def rate_params
    params.require(:rate).permit(:rate, :comment)
  end

end
