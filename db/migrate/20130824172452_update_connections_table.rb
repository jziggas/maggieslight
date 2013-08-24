class UpdateConnectionsTable < ActiveRecord::Migration
  def change
    remove_column :connections, :requestor_id
    remove_column :connections, :requested_id
    remove_column :connections, :requestor_type
    remove_column :connections, :requested_type
    remove_column :connections, :message
    add_column :connections, :message, :string
  end
end
