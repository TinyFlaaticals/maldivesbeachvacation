class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show create_booking ]

  def index
    @properties = Property.all

    # Handle search
    if params[:search].present?
      @properties = @properties.where("name ILIKE ? OR address ILIKE ? OR tagline ILIKE ? OR short_description ILIKE ?", 
                                      "%#{params[:search]}%", "%#{params[:search]}%", 
                                      "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # Store filter values for view
    @filtered_facilities = params[:facilities]
    @filtered_activities = params[:activities]
    @filtered_popular_filters = params[:popular_filters]
    @filtered_min_price = params[:min_price]
    @filtered_max_price = params[:max_price]
    @filtered_with_offer = params[:with_offer]
    @filtered_with_discount = params[:with_discount]
    @filtered_search = params[:search]
    @filtered_sort = params[:sort]

    # Handle price range checkboxes
    if params[:price_range].present?
      min_max = params[:price_range].split('-')
      @filtered_min_price = min_max[0]
      @filtered_max_price = min_max[1]
    end

    # Apply filters
    @properties = @properties.by_facilities(@filtered_facilities) if @filtered_facilities.present?
    @properties = @properties.by_activities(@filtered_activities) if @filtered_activities.present?
    @properties = @properties.by_popular_filters(@filtered_popular_filters) if @filtered_popular_filters.present?
    @properties = @properties.by_price_range(@filtered_min_price, @filtered_max_price) if @filtered_min_price.present? || @filtered_max_price.present?
    @properties = @properties.with_offer if @filtered_with_offer.present?
    @properties = @properties.with_discount if @filtered_with_discount.present?

    # Handle sorting
    case params[:sort]
    when 'price_low'
      @properties = @properties.order(:normal_price)
    when 'price_high'
      @properties = @properties.order(normal_price: :desc)
    when 'rating'
      @properties = @properties.order(star_rating: :desc)
    when 'name'
      @properties = @properties.order(:name)
    else
      # Default recommended sorting (could be by star_rating desc + price asc)
      @properties = @properties.order(star_rating: :desc, normal_price: :asc)
    end
  end

  def show
    @booking = Booking.new
  end

  def create_booking
    @booking = Booking.new(booking_params)
    @booking.property = @property

    if @booking.save
      BookingMailer.new_booking(@booking).deliver_now if defined?(BookingMailer)
      redirect_to booking_path(id: @booking.token), notice: "Booking was successfully created."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
    def set_property
      @property = Property.friendly.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:full_name, :email, :phone_number, :room_type, :meal_plan, :rooms, :adults, :children, :check_in, :check_out, :additional_service_request)
    end
end
