class AddVisibilityAttributeToProfiles < ActiveRecord::Migration
  def change
    add_column :care_receiver_profiles, :visibility, :string
    add_column :care_provider_profiles, :visibility, :string
  end
end
