require 'obscenity/active_model'

class Connection < ActiveRecord::Base
  before_validation { self.approval = false }

  belongs_to :requestor, class_name: 'User', polymorphic: true
  belongs_to :requested, class_name: 'User', polymorphic: true

  belongs_to :requestor_profile, polymorphic: true
  belongs_to :requested_profile, polymorphic: true

  validates :requestor_id, :requestor_profile_id, :requested_id, :requested_profile_id, :approval, presence: true

  validates :message, obscenity: { message: "One of your words appears profane to our system. Please revise."}

  self.per_page = 25
end