class AddColumnsPrivateEventDescriptionPhotoLatitudeLongitudeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :private_event, :string
    add_column :events, :description, :text
    add_column :events, :photo, :string
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
  end
end
