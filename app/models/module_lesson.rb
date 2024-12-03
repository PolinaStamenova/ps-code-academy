class ModuleLesson < ApplicationRecord
  # Associations
  belongs_to :course_module

  has_one_attached :video
  has_many_attached :documents

  # Validations
  validates :name, presence: true
end
