class CareReceiverProfilesController < ApplicationController
  load_and_authorize_resource
  before_action :set_page_feedback
  before_action :check_survey_status

  def flag
    @profile  = CareReceiverProfile.find_by id: params[:id]
    @current_user = current_user
    if @current_user.flagged?(@profile)
      @current_user.unflag(@profile)
      msg = "You have unflagged the profile."
    else
      @current_user.flag(@profile, :inappropriate)
      msg = "You have flagged the profile as inappropriate. Thank you for letting us know."
    end
    redirect_to care_receiver_profiles_path, notice: msg
  end

  def index
    @sort_column = sort_column
    @sort_direction = sort_direction
    @page = params[:page] || 1
    @profiles = CareReceiverProfile.available.search(params[:search]).order(@sort_column + " " + @sort_direction).paginate(page: params[:page])
  end

  def show
  end

  def new
    @care_receiver_profile = CareReceiverProfile.new
  end

  def edit
  end

  def create
    # build(attributes = {}, &block)
    # ActiveRecord::Associations::CollectionProxy

    # Returns a new object of the collection type that has been instantiated with attributes and linked to this object, but have not yet been saved. You can pass an array of attributes hashes, this will return an array with the new objects.
    @care_receiver_profile = current_user.care_receiver_profiles.build(care_receiver_profile_params)

    respond_to do |format|
      if @care_receiver_profile.save
        format.html { redirect_to @care_receiver_profile, notice: 'Care receiver profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @care_receiver_profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @care_receiver_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @care_receiver_profile.update(care_receiver_profile_params)
        format.html { redirect_to @care_receiver_profile, notice: 'Care receiver profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @care_receiver_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @care_receiver_profile.destroy
    respond_to do |format|
      format.html { redirect_to care_receiver_profiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_care_receiver_profile
      @care_receiver_profile = CareReceiverProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def care_receiver_profile_params
      params.require(:care_receiver_profile).permit(:name, :birthdate, :gender, :disabilities, :hobbies, :services_needed, :misc, :hours_needed, :days_needed, :city, :county, :transportation, :contact_name, :contact_email, :contact_phone, :profile_picture, :status)
    end

    def sort_column
      CareReceiverProfile.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
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
        if (@employment_surveys.empty? && current_user.created_at > 3.months) || ((Time.now - @employment_surveys.last.created_at)  > 3.months)
          redirect_to new_employment_survey_path
        end
      end
    end
end
