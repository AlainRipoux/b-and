class AddStatusToInvites < ActiveRecord::Migration[7.1]
  def change
    add_column :invites, :status, :string, default: "pending"
  end
end
