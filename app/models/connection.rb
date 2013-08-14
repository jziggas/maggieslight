require 'obscenity/active_model'

class Connection < ActiveRecord::Base
  belongs_to :user, polymorphic: true
  belongs_to :care_receiver_profile, polymorphic: true
  belongs_to :care_provider_profile, polymorphic: true

  validates :requestor_id, :requestor_profile_id, :requested_id, :requested_profile_id, :approval, presence: true

  validates :message, obscenity: { message: "One of your words appears profane to our system. Please revise."}
end