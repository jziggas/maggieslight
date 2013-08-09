class AddSomeIndexes < ActiveRecord::Migration
  def change
    add_index :care_receiver_profiles, :user_id, name: 'index_care_receiver_profiles_on_user_id'
    add_index :care_provider_profiles, :user_id, name: 'index_care_provider_profiles_on_user_id'
  end
end
