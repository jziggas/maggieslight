require 'obscenity/active_model'

class CareProviderProfile < ActiveRecord::Base
  belongs_to :user
  before_save { self.name = self.name.titleize }
  before_save { self.city = self.city.titleize }
  before_save { self.field_of_study = self.field_of_study.titleize }
  before_save { self.school = self.school.titleize }

  # Normalizes the attribute itself before validation
  phony_normalize :contact_phone, :default_country_code => 'US'

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "missing.jpg"

  validates_attachment_size :profile_picture, :less_than => 1.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']

  validates :contact_email, :email_format => {:message => 'is not looking good'}
  validates :county, inclusion: { in: BALTIMORE_COUNTIES, message: "%{value} is not a valid county"}
  validates :gender, inclusion: { in: %w(Male Female), message: "%{value} is an invalid gender"}
  validates :transportation, inclusion: { in: %w(Yes No), message: "%{value} is an invalid option"}
  validates :name, :city, :county, :field_of_study, :school, :contact_email, :contact_phone, :gender, :transportation, presence: true
  validates :contact_phone, phony_plausible: true
  validates :name, :city, :field_of_study, :school, :skills, :misc, :contact_email, obscenity: {message: "One of your words has been marked as profane"}

  validates :name, length: { in: 3..35 }
  validates :city, length: { in: 3..30 }
  validates :county, length: { in: 3..30 }
  validates :field_of_study, length: { in: 3..30 }
  validates :school, length: { in: 3..30 }
  validates :city, length: { in: 3..30 }
  validates :skills, length: { in: 3..250 }, allow_blank: true
  validates :misc, length: { in: 3..250 }, allow_blank: true
  validates :contact_email, length: { in: 3..50 }


  self.per_page = 3

  def self.search(search)
    if search
      where("name LIKE ? OR school LIKE ? OR field_of_study LIKE ? OR skills LIKE ? OR city LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
