class User < ActiveRecord::Base
  rolify before_add: :set_user
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :care_receiver_profiles
  has_many :care_provider_profiles
  #has_many :connections, as: :requestor
  #has_many :connections, as: :requested

  make_flagger

  has_many :flaggings, as: :flagger

  self.per_page = 10

  private

    def set_user
      self.add_role :user
    end
end
