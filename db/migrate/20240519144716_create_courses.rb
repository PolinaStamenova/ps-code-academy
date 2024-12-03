class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
