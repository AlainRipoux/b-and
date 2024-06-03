class CreateBands < ActiveRecord::Migration[7.1]
  def change
    create_table :bands do |t|
      t.string :name
      t.string :photo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
