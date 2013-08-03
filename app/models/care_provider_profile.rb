class CareProviderProfile < ActiveRecord::Base
  #attr_accessible :name, :location, :field_of_study, :school, :skills,
  #                :misc, :contact_email, :contact_phone

  belongs_to :user

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "/images/missing.png"

  validates_attachment_presence :profile_picture
  validates_attachment_size :profile_picture, :less_than => 1.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']

  self.per_page = 3

  def self.search(search)
    if search
      where("name LIKE ? OR school LIKE ? OR field_of_study LIKE ? OR skills LIKE ? OR location LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
