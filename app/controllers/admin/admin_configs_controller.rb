class Admin::AdminConfigsController < AdminApplicationController
  before_action :set_admin_config, only: %i[ show edit update destroy ]

  # GET /admin_configs or /admin_configs.json


  # GET /admin_configs/1 or /admin_configs/1.json
  def show
  end

  # GET /admin_configs/new
  def new
    @admin_config = AdminConfig.new
  end

  # GET /admin_configs/1/edit
  def edit
  end

  # POST /admin_configs or /admin_configs.json
  def create
    @admin_config = AdminConfig.new(admin_config_params)

    respond_to do |format|
      if @admin_config.save
        format.html { redirect_to @admin_config, notice: "Admin config was successfully created." }
        format.json { render :show, status: :created, location: @admin_config }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_configs/1 or /admin_configs/1.json
  def update
    respond_to do |format|
      if @admin_config.update(admin_config_params)
        format.html { redirect_to admin_admin_config_path, notice: "Admin config was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_config }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # Actions to remove attached images
  def remove_about_image
    @admin_config = AdminConfig.instance
    @admin_config.about_image.purge
    redirect_to edit_admin_admin_config_path, notice: "About image was successfully removed."
  end

  def remove_hero_image
    @admin_config = AdminConfig.instance
    @admin_config.hero_image.purge
    redirect_to edit_admin_admin_config_path, notice: "Hero image was successfully removed."
  end

  def remove_middle_image
    @admin_config = AdminConfig.instance
    @admin_config.middle_image.purge
    redirect_to edit_admin_admin_config_path, notice: "Middle image was successfully removed."
  end

  # DELETE /admin_configs/1 or /admin_configs/1.json
  def destroy
    @admin_config.destroy!

    respond_to do |format|
      format.html { redirect_to admin_configs_path, status: :see_other, notice: "Admin config was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_config
      @admin_config = AdminConfig.instance
    end

    # Only allow a list of trusted parameters through.
    def admin_config_params
      params.require(:admin_config).permit(
        :contact_email,
        :contact_phone,
        :office_hours_weekday,
        :office_hours_saturday,
        :hero_title,
        :hero_subtitle,
        :about_us,
        :about_image,
        :hero_image,
        :middle_image
      )
    end
end
