require 'obscenity/active_model'

class CareProviderProfile < ActiveRecord::Base
  belongs_to :user
  make_flaggable
  has_many :flaggings, as: :flaggable
  #has_many :connections, as: :requestor_profile
  #has_many :connections, as: :requested_profile

  before_save { self.name = self.name.titleize }
  before_save { self.city = self.city.titleize }
  before_save { self.field_of_study = self.field_of_study.titleize }
  before_save { self.school = self.school.titleize }

  scope :available, -> { where(status: "Looking To Care") }

  # Normalizes the attribute itself before validation
  phony_normalize :contact_phone, :default_country_code => 'US'

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "missing.jpg"

  validates_attachment_size :profile_picture, :less_than => 1.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']

  validates :contact_email, :email_format => {:message => 'is not a valid email address.'}
  validates :county, inclusion: { in: BALTIMORE_COUNTIES, message: "%{value} is not a valid county."}
  validates :gender, inclusion: { in: %w(Male Female), message: "%{value} is an invalid gender."}
  validates :transportation, inclusion: { in: %w(Yes No), message: "%{value} is an invalid option."}
  validates :name, :city, :county, :field_of_study, :school, :contact_email, :gender, :transportation, :status, presence: true
  validates :contact_phone, phony_plausible: true
  validates :status, inclusion: { in: ["Looking To Care", "Currently Busy"] }

  validates :name, :city, :field_of_study, :school, :skills, :misc, :contact_email, obscenity: { message: "One of your words appears profane to our system. Please revise."}

  validates :name, length: { in: 2..50 }
  validates :city, length: { in: 3..50 }
  validates :county, length: { in: 3..30 }
  validates :field_of_study, length: { in: 2..50 }
  validates :school, length: { in: 2..50 }
  validates :city, length: { in: 3..50 }
  validates :skills, length: { in: 3..1250 }, allow_blank: true
  validates :misc, length: { in: 3..1250 }, allow_blank: true
  validates :contact_email, length: { in: 3..50 }


  self.per_page = 7

  def self.search(search)
    if search
      where("lower(name) LIKE ? OR lower(school) LIKE ? OR lower(field_of_study) LIKE ? OR lower(skills) LIKE ? OR lower(city) LIKE ?", "%#{search.try(:downcase)}%","%#{search.try(:downcase)}%","%#{search.try(:downcase)}%","%#{search.try(:downcase)}%", "%#{search.try(:downcase)}%")
    else
      scoped
    end
  end
end
