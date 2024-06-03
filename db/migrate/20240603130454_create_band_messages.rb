class CreateBandMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :band_messages do |t|
      t.string :content
      t.references :band, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
