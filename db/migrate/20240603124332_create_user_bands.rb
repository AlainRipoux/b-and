class CreateUserBands < ActiveRecord::Migration[7.1]
  def change
    create_table :user_bands do |t|
      t.references :band, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
