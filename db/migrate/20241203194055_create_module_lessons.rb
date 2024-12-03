class CreateModuleLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :module_lessons do |t|
      t.string :name
      t.text :description

      t.references :course_module, null: false, foreign_key: true

      t.timestamps
    end
  end
end
