class AddLastNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_name, :string, default: '', null: false
  end
end
