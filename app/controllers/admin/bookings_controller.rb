class Admin::BookingsController < AdminApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /admin/bookings
  def index
    @bookings = Booking.all.order(created_at: :desc)
  end

  # GET /admin/bookings/1
  def show
    @property = @booking.property
  end

  # GET /admin/bookings/new
  def new
    @booking = Booking.new
  end

  # GET /admin/bookings/1/edit
  def edit
  end

  # POST /admin/bookings
  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to admin_booking_path(@booking), notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/bookings/1
  def update
    if @booking.update(booking_params)
      redirect_to admin_booking_path(@booking), notice: "Booking was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/bookings/1
  def destroy
    @booking.destroy!
    redirect_to admin_bookings_path, status: :see_other, notice: "Booking was successfully destroyed."
  end

  # DELETE /admin/bookings/clear_all
  def clear_all
    Booking.destroy_all
    redirect_to admin_bookings_path, status: :see_other, notice: "All bookings have been successfully removed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:property_id, :full_name, :email, :phone_number, :room_type, :meal_plan, :rooms, :adults, :children, :check_in, :check_out, :additional_service_request)
    end
end
