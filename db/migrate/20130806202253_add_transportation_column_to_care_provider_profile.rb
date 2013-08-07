class AddTransportationColumnToCareProviderProfile < ActiveRecord::Migration
  def change
    add_column :care_provider_profiles, :transportation, :string
  end
end
