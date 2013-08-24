class ChangeConnectionsApproval < ActiveRecord::Migration
  def change
    change_column :connections, :approval, :string, :default => "pending"
  end
end
