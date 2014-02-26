class CareProviderProfilesController < ApplicationController
  load_and_authorize_resource
  before_action :set_page_feedback
  before_action :check_survey_status

  def flag
    @profile  = CareProviderProfile.find_by id: params[:id]
    @current_user = current_user
    if @current_user.flagged?(@profile)
      @current_user.unflag(@profile)
      msg = "You have unflagged the profile."
    else
      @current_user.flag(@profile, :inappropriate)
      msg = "You have flagged the profile as inappropriate. Thank you for letting us know."
    end
    redirect_to care_provider_profiles_path, notice: msg
  end

  def index
    @sort_column = sort_column
    @sort_direction = sort_direction
    @page = params[:page] || 1
    @profiles = CareProviderProfile.available.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
    #@prof = CareProviderProfile.search(params[:search]).class
    #@page_feedback = PageFeedback.new
  end

  def show
  end

  def new
    @care_provider_profile = CareProviderProfile.new
  end

  def edit
  end

  def create

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
      params.require(:care_provider_profile).permit(:name, :city, :county, :gender, :transportation, :field_of_study, :school, :skills, :misc, :contact_email, :contact_phone, :profile_picture, :status)
    end

    def sort_column
      CareProviderProfile.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def set_page_feedback
      @page_feedback = PageFeedback.new
    end

    def set_employment_survey_id #deprecated
      if user_signed_in?
        @employment_survey_id = EmploymentSurvey.find_by_user_id(current_user.id)
      else
        @employment_survey_id = nil
      end
    end

    def check_survey_status
      if user_signed_in?
        @employment_surveys = current_user.employment_surveys.sort_by(&:created_at)
        if (@employment_surveys.empty? && current_user.created_at < 3.months.ago) || (@employment_surveys.last.created_at < 3.months.ago)
          redirect_to new_employment_survey_path
        end
      end
    end
end
