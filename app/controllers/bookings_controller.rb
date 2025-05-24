class BookingsController < ApplicationController
  def show
    @booking = find_booking

    if @booking.nil?
      redirect_to root_path, alert: "Booking not found."
    end
  end

  private

  def find_booking
    # First try to find by token
    booking = Booking.find_by(token: params[:id])

    # If not found by token, try to find by ID (for backward compatibility)
    booking ||= Booking.find_by(id: params[:id])

    booking
  end
end
