class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.references :band, null: false, foreign_key: true

      t.timestamps
    end
  end
end
