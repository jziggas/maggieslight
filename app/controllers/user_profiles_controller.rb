class UserProfilesController < ApplicationController
  def index
    if user_signed_in?
      @page = params[:page] || 1
      @profiles = current_user.care_receiver_profiles + current_user.care_provider_profiles
      @profiles = @profiles.paginate(page: @page, per_page: 5)
    else
      redirect_to root_path
    end
  end
end
