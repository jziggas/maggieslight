class CreateCareReceiverProfiles < ActiveRecord::Migration
  def change
    create_table :care_receiver_profiles do |t|
      t.string :name
      t.date :birthday
      t.string :gender
      t.string :disabilities
      t.string :hobbies
      t.string :services_needed
      t.string :misc
      t.string :hours_needed
      t.string :days_needed
      t.string :location
      t.string :transportation
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
