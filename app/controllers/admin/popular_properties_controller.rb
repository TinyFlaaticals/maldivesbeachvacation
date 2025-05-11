class Admin::PopularPropertiesController < AdminApplicationController
  before_action :set_popular_property, only: %i[ show edit update destroy ]

  # GET /popular_properties or /popular_properties.json
  def index
    @popular_properties = PopularProperty.all
  end

  # GET /popular_properties/1 or /popular_properties/1.json
  def show
  end

  # GET /popular_properties/new
  def new
    @popular_property = PopularProperty.new
  end

  # GET /popular_properties/1/edit
  def edit
  end

  # POST /popular_properties or /popular_properties.json
  def create
    @popular_property = PopularProperty.new(popular_property_params)

    respond_to do |format|
      if @popular_property.save
        format.html { redirect_to @popular_property, notice: "Popular property was successfully created." }
        format.json { render :show, status: :created, location: @popular_property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @popular_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /popular_properties/1 or /popular_properties/1.json
  def update
    respond_to do |format|
      if @popular_property.update(popular_property_params)
        format.html { redirect_to @popular_property, notice: "Popular property was successfully updated." }
        format.json { render :show, status: :ok, location: @popular_property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @popular_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /popular_properties/1 or /popular_properties/1.json
  def destroy
    @popular_property.destroy!

    respond_to do |format|
      format.html { redirect_to popular_properties_path, status: :see_other, notice: "Popular property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_popular_property
      @popular_property = PopularProperty.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def popular_property_params
      params.expect(popular_property: [ :property_id, :sort_order ])
    end
end
