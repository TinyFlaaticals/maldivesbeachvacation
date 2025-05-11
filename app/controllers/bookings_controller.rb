class BookingsController < ApplicationController
  def show
    @booking = Booking.find_by(token: params[:token])
  end
end
