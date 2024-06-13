class RenameLocationToAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :location, :address
  end
end
