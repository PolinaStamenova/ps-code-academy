class CourseModule < ApplicationRecord
  # Associations
  belongs_to :course
  has_many :module_lessons

  has_one_attached :video
  has_many_attached :documents

  # Validations
  validates :name, presence: true
end
