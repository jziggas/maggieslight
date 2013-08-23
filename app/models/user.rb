class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :care_receiver_profiles
  has_many :care_provider_profiles
  has_many :connections, class_name: 'Connection', foreign_key: :requestor_id, as: :requestor
  has_many :connections, class_name: 'Connection', foreign_key: :requested_id, as: :requested

  make_flagger

  has_many :flaggings, as: :flagger

  self.per_page = 10
end
