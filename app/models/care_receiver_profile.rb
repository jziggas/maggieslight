require 'obscenity/active_model'

class CareReceiverProfile < ActiveRecord::Base
  belongs_to :user
  make_flaggable
  has_many :flaggings, as: :flaggable
  has_many :connections, as: :requestor_profile
  has_many :connections, as: :requested_profile

  before_save { self.name = self.name.titleize }
  before_save { self.city = self.city.titleize }
  before_save { self.contact_name = self.contact_name.titleize }

  # Normalizes the attribute itself before validation
  phony_normalize :contact_phone, :default_country_code => 'US'

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "missing.jpg"

  validates_attachment_size :profile_picture, :less_than => 1.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']

  validates :contact_email, :email_format => {:message => 'is not looking like a real email address'}
  validates :county, inclusion: { in: BALTIMORE_COUNTIES, message: "%{value} is not a valid county"}
  validates :gender, inclusion: { in: %w(Male Female), message: "%{value} is not a valid gender"}
  validates :transportation, inclusion: { in: %w(Yes No), message: "%{value} is not a valid option"}
  validates :name, :birthdate, :gender, :disabilities, :hobbies, :services_needed, :days_needed, :city, :county, :transportation, :contact_name, :contact_email, :contact_phone, :status, presence: true
  validates :contact_phone, phony_plausible: true

  validates :status, inclusion: { in: ["Looking For Care", "Currently Cared For"]}

  validates :name, :disabilities, :hobbies, :services_needed, :misc, :hours_needed, :days_needed, :city, :contact_name, :contact_email, obscenity: { message: "One of your words appears profane to our system. Please revise."}

  validates :name, length: { in: 3..35 }
  validates :disabilities, length: { in: 3..250 }
  validates :hobbies, length: { in: 3..250 }
  validates :services_needed, length: { in: 3..250 }
  validates :misc, length: { in: 3..250 }, allow_blank: true
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
      if months > 0
        months > 1 ? months.to_s + " months" : months.to_s + " month"
      else
        days = now.day - dob.day
        if days > 0
          days > 1 ? days.to_s + " days" : days.to_s + " day"
        else
          "1 day"
        end
      end
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
