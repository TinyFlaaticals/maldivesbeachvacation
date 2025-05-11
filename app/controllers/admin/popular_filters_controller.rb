class Admin::PopularFiltersController < AdminApplicationController
  before_action :set_popular_filter, only: %i[ show edit update destroy ]

  # GET /popular_filters or /popular_filters.json
  def index
    @popular_filters = PopularFilter.all
  end

  # GET /popular_filters/1 or /popular_filters/1.json
  def show
  end

  # GET /popular_filters/new
  def new
    @popular_filter = PopularFilter.new
  end

  # GET /popular_filters/1/edit
  def edit
  end

  # POST /popular_filters or /popular_filters.json
  def create
    @popular_filter = PopularFilter.new(popular_filter_params)

    respond_to do |format|
      if @popular_filter.save
        format.html { redirect_to admin_popular_filters_path, notice: "Popular filter was successfully created." }
        format.json { render :show, status: :created, location: @popular_filter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @popular_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /popular_filters/1 or /popular_filters/1.json
  def update
    respond_to do |format|
      if @popular_filter.update(popular_filter_params)
        format.html { redirect_to admin_popular_filters_path, notice: "Popular filter was successfully updated." }
        format.json { render :show, status: :ok, location: @popular_filter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @popular_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /popular_filters/1 or /popular_filters/1.json
  def destroy
    @popular_filter.destroy!

    respond_to do |format|
      format.html { redirect_to admin_popular_filters_path, status: :see_other, notice: "Popular filter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_popular_filter
      @popular_filter = PopularFilter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def popular_filter_params
      params.expect(popular_filter: [ :name ])
    end
end
