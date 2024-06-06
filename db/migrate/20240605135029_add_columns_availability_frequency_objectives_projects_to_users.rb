class AddColumnsAvailabilityFrequencyObjectivesProjectsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :availability, :string
    add_column :users, :frequency, :string
    add_column :users, :objectives, :string
    add_column :users, :projects, :string
  end
end
