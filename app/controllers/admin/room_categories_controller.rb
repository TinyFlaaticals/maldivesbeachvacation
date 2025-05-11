class Admin::RoomCategoriesController < AdminApplicationController
  before_action :set_property
  before_action :set_room_category, only: %i[ show edit update destroy ]

  # GET /room_categories or /room_categories.json
  def index
    @room_categories = RoomCategory.all
  end

  # GET /room_categories/1 or /room_categories/1.json
  def show
  end

  # GET /room_categories/new
  def new
    @room_category = RoomCategory.new
  end

  # GET /room_categories/1/edit
  def edit
  end

  # POST /room_categories or /room_categories.json
  def create
    @room_category = RoomCategory.new(room_category_params)
    @room_category.property = @property

    respond_to do |format|
      if @room_category.save
        format.html { redirect_to admin_property_path(@property), notice: "Room category was successfully created." }
        format.json { render :show, status: :created, location: @room_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_categories/1 or /room_categories/1.json
  def update
    respond_to do |format|
      if @room_category.update(room_category_params)
        format.html { redirect_to admin_property_path(@property), notice: "Room category was successfully updated." }
        format.json { render :show, status: :ok, location: @room_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_categories/1 or /room_categories/1.json
  def destroy
    @room_category.destroy!

    respond_to do |format|
      format.html { redirect_to admin_property_room_categories_path(@property), status: :see_other, notice: "Room category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_property
    @property = Property.friendly.find(params[:property_id])
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_room_category
      @room_category = RoomCategory.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def room_category_params
      params.expect(room_category: [ :name, :normal_price, :discounted_price, :discount_percent ])
    end
end
