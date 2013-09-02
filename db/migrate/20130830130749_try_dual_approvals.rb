class TryDualApprovals < ActiveRecord::Migration
  def change
    remove_column :connections, :requestor_profile_id, :integer
    remove_column :connections, :requested_profile_id, :integer
    remove_column :connections, :requestor_profile_type, :string
    remove_column :connections, :requested_profile_type, :string
    remove_column :connections, :approval, :string

    add_column :connections, :care_receiver_profile_id, :integer
    add_column :connections, :care_provider_profile_id, :integer
    add_column :connections, :care_receiver_profile_approval, :string
    add_column :connections, :care_provider_profile_approval, :string
  end
end
