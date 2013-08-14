class CreateConnection < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :requestor_id
      t.integer :requested_id
      t.integer :requestor_profile_id
      t.integer :requested_profile_id
      t.boolean :approval
      t.text :message
    end
  end
end
