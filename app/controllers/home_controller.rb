class HomeController < ApplicationController
  def index
    @page = params[:page] || 1
    @profiles = CareReceiverProfile.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
    @prof = CareReceiverProfile.search(params[:search]).class
  end

  private
    def sort_column
      CareReceiverProfile.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
