class AddAttachmentProfilePictureToVolunteerOpportunities < ActiveRecord::Migration
  def self.up
    change_table :volunteer_opportunities do |t|
      t.attachment :profile_picture
    end
  end

  def self.down
    drop_attached_file :volunteer_opportunities, :profile_picture
  end
end
