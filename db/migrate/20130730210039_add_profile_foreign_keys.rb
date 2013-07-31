class AddProfileForeignKeys < ActiveRecord::Migration
  def change
    add_column :care_receiver_profiles, :user_id, :integer
    add_column :care_provider_profiles, :user_id, :integer
  end
end
