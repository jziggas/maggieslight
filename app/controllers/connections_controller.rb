class ConnectionsController < ApplicationController
  load_and_authorize_resource
  #before_action :load_resource

  def index
  end

  def show
  end

  def new
    @connection = Connection.new
    if params[:care_receiver_profile_id]

      @requested_profile = CareReceiverProfile.find(params[:care_receiver_profile_id])
      @requestor_profiles = CareProviderProfile.where(id: current_user.id)

    elsif params[:care_provider_profile_id]

      @requested_profile = CareProviderProfile.find(params[:care_provider_profile_id])
      @requestor_profiles = CareReceiverProfile.where(id: current_user.id)

    else
      redirect_to root_path, notice: "Nothing happened. Something broke."
    end
  end

  def create
    #@connection = current_user.connections.build connection_params
    #@requestor_id = { :requestor_id => current_user.id }
    #@params = connection_params.merge(@requestor_id)
    @message = params[:connection][:message]

    if params[:care_receiver_profile_id]
      @care_receiver_profile_id = params[:care_receiver_profile_id]
      @care_provider_profile_id = params[:connection][:care_provider_profile_id]
      @care_receiver_profile_approval = "pending"
      @care_provider_profile_approval = "approved"
    elsif params[:care_provider_profile_id]
      @care_receiver_profile_id = params[:connection][:care_receiver_profile_id]
      @care_provider_profile_id = params[:care_provider_profile_id]
      @care_receiver_profile_approval = "approved"
      @care_provider_profile_approval = "pending"
    end

    @connection = Connection.new connection_params
    @connection.message = @message
    @connection.care_provider_profile_approval = @care_provider_profile_approval
    @connection.care_receiver_profile_approval = @care_receiver_profile_approval
    @connection.care_provider_profile_id = @care_provider_profile_id
    @connection.care_receiver_profile_id = @care_receiver_profile_id

    if @connection.save
      redirect_to root_path, notice: "Thank you for your request. You will be notified of approval."
    else
      redirect_to root_path , notice: params[:errors]
    end
  end

  def update
  end

  def destroy
    @connection.destroy
    redirect_to root_path
  end

  private

    def set_connection
    end

    #def connection_params
    #  params.require(:connection).permit(:requestor_id, :requested_id, :requestor_profile_id, :requested_profile_id, :message, :requested_type, :requested_profile_type, :requestor_profile_type, :requestor_type)
    #end

    def connection_params
      params.require(:connection).permit(:message, :care_receiver_profile_id, :care_provider_profile_id, :care_receiver_profile_approval, :care_provider_profile_approval)
    end

    #def load_resource
      #resource, id = request.path.split('/')[1, 2]
      #@resource = resource.singularize.classify.constantize.find(id)
    #end

end