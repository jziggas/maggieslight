class CreateVolunteerOpportunities < ActiveRecord::Migration
  def change
    create_table :volunteer_opportunities do |t|
      t.string :org_name
      t.string :event_type
      t.string :description
      t.string :contact_phone
      t.string :contact_name
      t.string :contact_email
      t.datetime :event_start
      t.datetime :event_end
      t.integer :user_id
      t.boolean :agree_terms
      t.string :ein
      t.string :type_of_org
      t.string :title
      t.string :location

      t.timestamps
    end
  end
end
