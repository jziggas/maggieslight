  require 'obscenity/active_model'

class Connection < ActiveRecord::Base
  # before_validation { self.approval = false }

  #belongs_to :requestor, class_name: 'User', polymorphic: true
  #belongs_to :requested, class_name: 'User', polymorphic: true

  # Connection.where("approval = 'approved'")
  scope :approved, -> { where("care_receiver_profile_approval = 'approved' AND care_provider_profile_approval = 'approved'") }
  scope :pending, -> { where("care_receiver_profile_approval = 'pending' OR care_provider_profile_approval = 'pending'") }
  scope :rejected, -> { where("care_receiver_profile_approval = 'rejected' OR care_provider_profile_approval = 'rejected'") }

  belongs_to :care_provider_profile
  belongs_to :care_receiver_profile

  STATES = %w(pending approved rejected)

  validates :care_receiver_profile_approval, :care_provider_profile_approval, inclusion: { in: STATES }

  validates :care_receiver_profile_id, :care_provider_profile_id, :care_receiver_profile_approval, :care_provider_profile_approval, presence: true

  validates :message, obscenity: { message: "One of your words appears profane to our system. Please revise."}

  self.per_page = 25

  # in migration
  # change_column :connections, :approval, :string, :default => "pending"
end