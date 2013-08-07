class CareProviderProfilesController < ApplicationController
  load_and_authorize_resource
  #before_action :set_care_provider_profile, only: [:show, :edit, :update, :destroy]

  # GET /care_provider_profiles
  # GET /care_provider_profiles.json
  def index
    @page = params[:page] || 1
    @profiles = CareProviderProfile.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
    @prof = CareProviderProfile.search(params[:search]).class
  end

  # GET /care_provider_profiles/1
  # GET /care_provider_profiles/1.json
  def show
  end

  # GET /care_provider_profiles/new
  def new
    @care_provider_profile = CareProviderProfile.new
  end

  # GET /care_provider_profiles/1/edit
  def edit
  end

  # POST /care_provider_profiles
  # POST /care_provider_profiles.json
  def create
    # @care_provider_profile = CareProviderProfile.new(care_provider_profile_params)
    # See care_receiver_profiles#create for notes

    @care_provider_profile = current_user.care_provider_profiles.build(care_provider_profile_params)

    respond_to do |format|
      if @care_provider_profile.save
        format.html { redirect_to @care_provider_profile, notice: 'Care provider profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @care_provider_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @care_provider_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /care_provider_profiles/1
  # PATCH/PUT /care_provider_profiles/1.json
  def update
    respond_to do |format|
      if @care_provider_profile.update(care_provider_profile_params)
        format.html { redirect_to @care_provider_profile, notice: 'Care provider profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @care_provider_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /care_provider_profiles/1
  # DELETE /care_provider_profiles/1.json
  def destroy
    @care_provider_profile.destroy
    respond_to do |format|
      format.html { redirect_to care_provider_profiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_care_provider_profile
      @care_provider_profile = CareProviderProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def care_provider_profile_params
      params.require(:care_provider_profile).permit(:name, :city, :county, :gender, :transportation, :field_of_study, :school, :skills, :misc, :contact_email, :contact_phone, :profile_picture)
    end

  private
    def sort_column
      CareProviderProfile.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
