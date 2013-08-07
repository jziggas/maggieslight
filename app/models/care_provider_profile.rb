class CareProviderProfile < ActiveRecord::Base
  belongs_to :user

  # Normalizes the attribute itself before validation
  phony_normalize :contact_phone, :default_country_code => 'US'

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "missing.jpg"

  validates_attachment_size :profile_picture, :less_than => 1.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']

  validates :contact_email, :email_format => {:message => 'is not looking good'}
  validates :county, inclusion: { in: BALTIMORE_COUNTIES, message: "%{value} is not a valid county"}
  validates :gender, inclusion: { in: %w(Male Female), message: "%{value} is an invalid gender"}
  validates :transportation, inclusion: { in: %w(Yes No), message: "%{value} is an invalid gender"}
  validates :name, :city, :county, :field_of_study, :school, :contact_email, :contact_phone, :gender, :transportation, presence: true
  validates :contact_phone, phony_plausible: true

  self.per_page = 3

  def self.search(search)
    if search
      where("name LIKE ? OR school LIKE ? OR field_of_study LIKE ? OR skills LIKE ? OR city LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
