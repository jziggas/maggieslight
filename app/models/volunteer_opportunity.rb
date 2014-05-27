require 'obscenity/active_model'

class VolunteerOpportunity < ActiveRecord::Base
  belongs_to :user
  make_flaggable
  has_many :flaggings, as: :flaggable

  @@org_types = ['Non-Profit', 'School K-12', 'Higher Education', 'For-Profit', 'Political Campaign', 'Non-US Organization']
  self.per_page = 7

  before_save { self.contact_name = self.contact_name.titleize }
  before_save { self.location = self.location }
  before_save { self.title = self.title.titleize }

  scope :not_expired, -> { where('event_end > ?', DateTime.now) }

  has_attached_file :profile_picture, :styles => { :large => "450x450", :medium => "350x350>", :thumb => "150x150>" }, :default_url => "missing.jpg"

  has_attached_file :required_documents

  phony_normalize :contact_phone, :default_country_code => 'US'

  validates :contact_email, :email_format => {:message => 'is not a valid email address.'}
  validates :contact_name, :location, :org_name, :event_type, :description, :contact_phone, :contact_name, :contact_email, :event_start, :event_end, :agree_terms, :ein, :title, presence: true
  validates :contact_phone, phony_plausible: true

  validates_attachment_size :profile_picture, :less_than => 1.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpg', 'image/jpeg', 'image/png']
  validates_attachment_size :required_documents, :less_than => 5.megabytes

  validates :type_of_org, inclusion: { in: @@org_types }

  validates :org_name, :event_type, :description, :contact_phone, :contact_name, :contact_email, :event_start, :event_end, :user_id, :agree_terms, :ein, :type_of_org, :title, :location, presence: true

  validates :org_name, :event_type, :description, :contact_phone, :contact_name, :contact_email, :event_start, :event_end, :user_id, :agree_terms, :ein, :type_of_org, :title, :location, obscenity: { message: "One of your words appears profane to our system. Please revise."}

  validates :contact_email, :email_format => {  :message => 'is not a valid email address.' }

  validates :agree_terms, inclusion: { in: [ true ] }

  validates :org_name, length: { in: 2..30 }
  validates :event_type, length: { in: 2..15 }
  validates :description, length: { in: 5..500 }
  validates :contact_phone, length: { in: 1..20 }
  validates :contact_name, length: { in: 3..50 }
  validates :contact_email, length: { in: 3..50 }
  validates :event_start, length: { in: 3..30 }
  validates :event_end, length: { in: 3..30 }
  validates :user_id, length: { in: 1..5 }
  validates :ein, length: { in: 1..15}
  validates :title, length: { in: 3..20 }
  validates :location, length: { in: 2..20 }

  def self.search(search)
    if search
      where("lower(title) LIKE ? OR lower(location) LIKE ? OR lower(org_name) LIKE ? OR lower(event_type) LIKE ? OR lower(contact_name) LIKE ?", "%#{search.try(:downcase)}%","%#{search.try(:downcase)}%","%#{search.try(:downcase)}%","%#{search.try(:downcase)}%", "%#{search.try(:downcase)}%")
    else
      scoped
    end
  end

  def self.org_types
    @@org_types
  end
end
