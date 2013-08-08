require 'obscenity/active_model'

class CareReceiverProfile < ActiveRecord::Base
  #attr_accessible :name, :birthday, :gender, :disabilities, :hobbies,
  #                :services_needed, :misc, :hours_needed, :days_needed,
  #                :location, :transportation, :contact_name, :contact_email,
  #                :contact_phone

  belongs_to :user

  # Normalizes the attribute itself before validation
  phony_normalize :contact_phone, :default_country_code => 'US'

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "missing.jpg"

  validates_attachment_size :profile_picture, :less_than => 1.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']

  validates :contact_email, :email_format => {:message => 'is not looking good'}
  validates :county, inclusion: { in: BALTIMORE_COUNTIES, message: "%{value} is not a valid county"}
  validates :gender, inclusion: { in: %w(Male Female), message: "%{value} is an invalid gender"}
  validates :transportation, inclusion: { in: %w(Yes No), message: "%{value} is an invalid option"}
  validates :name, :birthdate, :gender, :disabilities, :hobbies, :services_needed, :days_needed, :city, :county, :transportation, :contact_name, :contact_email, :contact_phone, presence: true
  validates :contact_phone, phony_plausible: true

  validates :name, :disabilities, :hobbies, :services_needed, :misc, :hours_needed, :days_needed, :city, :contact_name, :contact_email, obscenity: {message: "One of your words has been marked as profane"}

  validates :name, length: { in: 3..35 }
  validates :disabilities, length: { in: 3..250 }
  validates :hobbies, length: { in: 3..250 }
  validates :services_needed, length: { in: 3..250 }
  validates :misc, length: { in: 3..250 }
  validates :hours_needed, length: { in: 3..250 }, allow_blank: true
  validates :days_needed, length: { in: 3..250 }
  validates :city, length: { in: 3..20 }
  validates :county, length: { in: 3..30 }
  validates :contact_name, length: { in: 3..35 }
  validates :contact_email, length: { in: 3..50 }

  self.per_page = 3

  def age
    dob = self.birthdate
    now = Time.now.utc.to_date
    years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    if years > 0
      years.to_s + " years"
    else
      months = now.month - dob.month
      months > 1 ? months.to_s + " months" : months.to_s + " month"
    end
  end

  def self.search(search)
    if search
      where("name LIKE ? OR gender LIKE ? OR disabilities LIKE ? OR services_needed LIKE ? OR city LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
