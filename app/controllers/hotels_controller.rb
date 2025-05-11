class HotelsController < ApplicationController
  include ActiveStorage::SetCurrent
  before_action :set_hotel, only: [ :show ]
  def index
    @hotels = Hotel.all
  end

  def show
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end
end
