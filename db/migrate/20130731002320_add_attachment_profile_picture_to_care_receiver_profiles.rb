class AddAttachmentProfilePictureToCareReceiverProfiles < ActiveRecord::Migration
  def self.up
    change_table :care_receiver_profiles do |t|
      t.attachment :profile_picture
    end
  end

  def self.down
    drop_attached_file :care_receiver_profiles, :profile_picture
  end
end
