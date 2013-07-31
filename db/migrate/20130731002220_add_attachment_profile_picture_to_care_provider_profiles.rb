class AddAttachmentProfilePictureToCareProviderProfiles < ActiveRecord::Migration
  def self.up
    change_table :care_provider_profiles do |t|
      t.attachment :profile_picture
    end
  end

  def self.down
    drop_attached_file :care_provider_profiles, :profile_picture
  end
end
