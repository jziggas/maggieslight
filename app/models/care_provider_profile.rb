class CareProviderProfile < ActiveRecord::Base
  #attr_accessible :name, :location, :field_of_study, :school, :skills,
  #                :misc, :contact_email, :contact_phone

  belongs_to :user

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "/images/missing.png"

  validates_attachment_presence :profile_picture
  validates_attachment_size :profile_picture, :less_than => 5.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']
end
