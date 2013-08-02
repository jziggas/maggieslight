class CareReceiverProfile < ActiveRecord::Base
  #attr_accessible :name, :birthday, :gender, :disabilities, :hobbies,
  #                :services_needed, :misc, :hours_needed, :days_needed,
  #                :location, :transportation, :contact_name, :contact_email,
  #                :contact_phone

  belongs_to :user

  has_attached_file :profile_picture, :styles => { :large => "350x350", :medium => "250x250>", :thumb => "150x150>" }, :default_url => "assets/images/missing.png"

  validates_attachment_presence :profile_picture
  validates_attachment_size :profile_picture, :less_than => 5.megabytes
  validates_attachment_content_type :profile_picture, :content_type => ['image/jpeg', 'image/png']

  self.per_page = 3

  def age
    dob = self.birthdate
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def self.search(search)
    if search
      where("name LIKE ? OR gender LIKE ? OR disabilities LIKE ? OR services_needed LIKE ? OR location LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
