class Purchase < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :item, class_name: 'Course'

  # Enums
  enum status: { pending: 0, failed: 1, canceled: 2, succeeded: 3 }
end
