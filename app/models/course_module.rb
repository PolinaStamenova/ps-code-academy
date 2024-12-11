class CourseModule < ApplicationRecord
  # Associations
  belongs_to :course
  has_many :module_lessons

  has_one_attached :video
  has_many_attached :documents

  # Validations
  validates :name, presence: true
  validate :name_unique_as_slug

  # Callbacks
  before_validation :set_slug

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = name.parameterize if name.present?
  end

  def name_unique_as_slug
    return unless name.present?

    return unless course.course_modules.exists?(slug: name.parameterize)

    errors.add(:name, 'already exists in the scope of this course. Please choose a different name.')
  end
end
