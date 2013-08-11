class AddStatusColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :care_receiver_profiles, :status, :string
    add_column :care_provider_profiles, :status, :string
  end
end
