class AddSlugToModuleLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :module_lessons, :slug, :string, null: false
    add_index :module_lessons, [:course_module_id, :slug], unique: true
  end
end
