class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :nickname, :string
    add_column :users, :instrument, :string
    add_column :users, :biography, :string
    add_column :users, :style, :string
    add_column :users, :address, :string
  end
end
