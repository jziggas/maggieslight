class CareReceiverProfilesController < ApplicationController
  load_and_authorize_resource
  #before_action :set_care_receiver_profile, only: [:show, :edit, :update, :destroy]

  # GET /care_receiver_profiles
  # GET /care_receiver_profiles.json
  def index
    @sort_column = sort_column
    @sort_direction = sort_direction
    @page = params[:page] || 1
    @profiles = CareReceiverProfile.search(params[:search]).order(@sort_column + " " + @sort_direction).paginate(page: params[:page])
  end

  # GET /care_receiver_profiles/1
  # GET /care_receiver_profiles/1.json
  def show
  end

  # GET /care_receiver_profiles/new
  def new
    @care_receiver_profile = CareReceiverProfile.new
  end

  # GET /care_receiver_profiles/1/edit
  def edit
  end

  # POST /care_receiver_profiles
  # POST /care_receiver_profiles.json
  def create
    # @care_receiver_profile = CareReceiverProfile.new(care_receiver_profile_params)
=begin
    build(attributes = {}, &block)
    ActiveRecord::Associations::CollectionProxy

    Returns a new object of the collection type that has been instantiated with attributes and linked to this object, but have not yet been saved. You can pass an array of attributes hashes, this will return an array with the new objects.
=end
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

  # PATCH/PUT /care_receiver_profiles/1
  # PATCH/PUT /care_receiver_profiles/1.json
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

  # DELETE /care_receiver_profiles/1
  # DELETE /care_receiver_profiles/1.json
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
      params.require(:care_receiver_profile).permit(:name, :birthdate, :gender, :disabilities, :hobbies, :services_needed, :misc, :hours_needed, :days_needed, :city, :county, :transportation, :contact_name, :contact_email, :contact_phone, :profile_picture)
    end

  private
    def sort_column
      CareReceiverProfile.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
