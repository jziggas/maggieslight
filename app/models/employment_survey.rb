class EmploymentSurvey < ActiveRecord::Base
  belongs_to :user
  ADS = ['Family', 'Individual', 'Student Caregiver']
  YESNO = ['Yes', 'No']
  validates :user_id, :kind_of_ad, :contact, presence: true
  validates :kind_of_ad, inclusion: { in: ADS}
  validates :contact, inclusion: { in: YESNO }
  validates :employment, inclusion: { in: YESNO }, allow_blank: true
end
