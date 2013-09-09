class UserProfilesController < ApplicationController
  before_action :set_page_feedback

  def index
    if user_signed_in?
      @page = params[:page] || 1
      @profiles = current_user.care_receiver_profiles + current_user.care_provider_profiles
      @profiles = @profiles.paginate(page: @page, per_page: 2)
      #@profiles[0].class.to_s.underscore.titleize}"
    else
      redirect_to root_path
    end
  end

  private

    def set_page_feedback
      @page_feedback = PageFeedback.new
    end
end
