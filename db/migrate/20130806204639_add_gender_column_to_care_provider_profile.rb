class AddGenderColumnToCareProviderProfile < ActiveRecord::Migration
  def change
    add_column :care_provider_profiles, :gender, :string
  end
end
