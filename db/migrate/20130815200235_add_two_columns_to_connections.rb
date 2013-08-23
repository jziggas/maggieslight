class AddTwoColumnsToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :requestor_profile_type, :string
    add_column :connections, :requested_profile_type, :string
  end
end
