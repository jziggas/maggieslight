class ChangeLocationColumns < ActiveRecord::Migration
  def change
    rename_column :care_receiver_profiles, :location, :city

    rename_column :care_provider_profiles, :location, :city
  end
end
