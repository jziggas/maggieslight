class CreateCareProviderProfiles < ActiveRecord::Migration
  def change
    create_table :care_provider_profiles do |t|
      t.string :name
      t.string :location
      t.string :field_of_study
      t.string :school
      t.string :skills
      t.string :misc
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
