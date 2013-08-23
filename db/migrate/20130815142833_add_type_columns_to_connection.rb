class AddTypeColumnsToConnection < ActiveRecord::Migration
  def change
    add_column :connections, :requestor_type, :string
    add_column :connections, :requested_type, :string
  end
end
