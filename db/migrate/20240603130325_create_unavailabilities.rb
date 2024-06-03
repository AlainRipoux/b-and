class CreateUnavailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :unavailabilities do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
