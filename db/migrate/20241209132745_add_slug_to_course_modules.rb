class AddSlugToCourseModules < ActiveRecord::Migration[7.0]
  def change
    add_column :course_modules, :slug, :string, null: false
    add_index :course_modules, [:course_id, :slug], unique: true
  end
end
