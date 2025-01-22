class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :github_repo_link, null: true, default: nil
      t.integer :estimated_time_in_minutes, null: true, default: nil

      t.references :course_module, null: false, foreign_key: true

      t.timestamps
    end
  end
end
