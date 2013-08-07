class AddCountiesColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :care_receiver_profiles, :county,  :string
    add_column :care_provider_profiles, :county, :string
  end
end
