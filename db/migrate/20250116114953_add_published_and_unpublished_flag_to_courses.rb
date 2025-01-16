class AddPublishedAndUnpublishedFlagToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :published_at, :datetime, default: nil
    add_column :courses, :unpublished_at, :datetime, default: nil
  end
end
