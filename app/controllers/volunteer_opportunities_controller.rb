class VolunteerOpportunitiesController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:create]

  before_action :set_page_feedback
  before_action :check_survey_status

  def flag
    @volunteer_opportunity  = VolunteerOpportunity.find_by id: params[:id]
    @current_user = current_user
    if @current_user.flagged?(@volunteer_opportunity)
      @current_user.unflag(@volunteer_opportunity)
      msg = "You have unflagged the ad."
    else
      @current_user.flag(@volunteer_opportunity, :inappropriate)
      msg = "You have flagged the ad as inappropriate. Thank you for letting us know."
    end
    redirect_to volunteer_opporunities_path, notice: msg
  end

  def index
    @sort_column = sort_column
    @sort_direction = sort_direction
    @page = params[:page] || 1
    @profiles = VolunteerOpportunity.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page]).not_expired
  end

  def show
  end

  def new
    @volunteer_opportunity = VolunteerOpportunity.new
  end

  def edit
  end

  def create
    op_params    = volunteer_opportunity_params
    event_start  = op_params.delete("event_start")  # see below as to why we extract these now
    event_end    = op_params.delete("event_end")

    @volunteer_opportunity = current_user.volunteer_opportunities.build(op_params)

    # don't trust Date.parse to make the right decisions, as it didn't seem to
    # in this case. Instead we know the format - even though it's specified with
    # a different style format string - and set the start and end times to DateTimes
    # ourselves.
    @volunteer_opportunity.event_start = DateTime.strptime(event_start, '%m/%d/%Y %I:%M %p')
    @volunteer_opportunity.event_end   = DateTime.strptime(event_end, '%m/%d/%Y %I:%M %p')

    respond_to do |format|
      if @volunteer_opportunity.save
        format.html { redirect_to @volunteer_opportunity, notice: 'Volunteer Opportunity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @volunteer_opportunity }
      else
        format.html { render action: 'new' }
        format.json { render json: @volunteer_opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @volunteer_opportunity.update(volunteer_opportunity_params)
        format.html { redirect_to @volunteer_opportunity, notice: 'Volunteer Opportunity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @volunteer_opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @volunteer_opportunity.destroy
    respond_to do |format|
      format.html { redirect_to volunteer_opportunities_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer_opportunity
      @volunteer_opportunity = VolunteerOpportunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_opportunity_params
      params.require(:volunteer_opportunity).permit(:org_name, :event_type, :description, :contact_phone, :contact_name, :contact_email, :event_start, :event_end, :user_id, :agree_terms, :ein, :type_of_org, :title, :location, :required_documents, :profile_picture)
    end

    def sort_column
      VolunteerOpportunity.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
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
      if user_signed_in? && !current_user.is_admin?
        @employment_surveys = current_user.employment_surveys.sort_by(&:created_at)
        if @employment_surveys.empty?
          if current_user.created_at < 4.weeks.ago
            redirect_to new_employment_survey_path
          end
        elsif
          @employment_surveys.last.created_at < 4.weeks.ago
            redirect_to new_employment_survey_path
        end
      end
    end

end
