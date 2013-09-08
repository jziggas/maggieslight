class ChangeSomeColumnsToText < ActiveRecord::Migration
  def change
    change_column :care_provider_profiles, :skills, :text
    change_column :care_provider_profiles, :misc, :text
    change_column :care_receiver_profiles, :disabilities, :text
    change_column :care_receiver_profiles, :hobbies, :text
    change_column :care_receiver_profiles, :services_needed, :text
    change_column :care_receiver_profiles, :misc, :text
  end
end
