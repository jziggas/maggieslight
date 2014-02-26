class EmploymentSurveysController < ApplicationController
   load_and_authorize_resource

   def new
    @employment_survey = EmploymentSurvey.new
   end

   def create
    @employment_survey = current_user.employment_surveys.build(employment_survey_params)
    if @employment_survey.save
      redirect_to root_path, notice: "Thank you!"
    else
      render action: 'new'
    end
   end

   def edit
   end

   def update
    if @employment_survey.update( employment_survey_params )
      redirect_to root_path, notice: "Thank you!"
    else
      render action: 'edit'
    end
   end

   private

    def employment_survey_params
      params.require(:employment_survey).permit(:kind_of_ad, :contact, :employment)
    end
end