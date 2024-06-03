class ChangeColumnToTask < ActiveRecord::Migration[7.1]
  def change
    change_column :tasks, :done, :boolean, :default => false
  end
end
