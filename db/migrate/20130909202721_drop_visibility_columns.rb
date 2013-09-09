class DropVisibilityColumns < ActiveRecord::Migration
  def change
    remove_column :care_receiver_profiles, :visibility
    remove_column :care_provider_profiles, :visibility
  end
end
