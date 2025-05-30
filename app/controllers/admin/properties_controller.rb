class Admin::PropertiesController < AdminApplicationController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.all
  end

  def show
  end

  def new
    @property = Property.new
  end

  def edit
  end

  def create
    @property = Property.new(property_params)

    if @property.save
      redirect_to admin_property_path(@property), notice: "Property was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      redirect_to admin_property_path(@property), notice: "Property was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy!
    redirect_to admin_properties_path, status: :see_other, notice: "Property was successfully destroyed."
  end

  private

  def set_property
    @property = Property.friendly.find(params[:id])
  end

  def property_params
    params.require(:property).permit(
      :name, :address, :tagline,
      :short_description, :latitude, :longitude,
      :normal_price, :discounted_price, :discount_percent,
      :discount_text, :offer_text, :overview, :star_rating,
      facility_ids: [],
      activity_ids: [],
      popular_filter_ids: [],
      property_images_attributes: [ :id, :image, :_destroy ],
      room_categories_attributes: [
        :id, :name, :normal_price, :discounted_price, :discount_percent,
        :short_description, :full_description,
        :size_sqm, :size_sqft,
        :max_adults, :max_children,
        :num_bedrooms, :num_bathrooms, :bed_configuration,
        :has_pool, :has_beach_access, :has_ocean_view,
        { comfort_amenities: [] }, { convenience_features: [] },
        :_destroy
      ]
    )
  end
end
