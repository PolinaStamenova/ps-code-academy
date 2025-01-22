class CourseModule < ApplicationRecord
  # Associations
  belongs_to :course
  has_many :module_lessons, dependent: :destroy
  has_many :assignments, dependent: :destroy

  # ActiveStorage
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

  def duration
    total_seconds = module_lessons.sum do |lesson|
      next 0 unless lesson.video.attached?

      blob = lesson.video.blob

      ActiveStorage::Analyzer::VideoAnalyzer.new(blob).metadata[:duration].to_i
    end

    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60

    "#{hours}hr #{minutes}min"
  end

  private

  def set_slug
    self.slug = name.parameterize if name.present?
  end

  # TODO: Fix: when updating a record and there is another one with the same name pg error is thrown
  def name_unique_as_slug
    return unless name.present?

    return unless course.course_modules.exists?(slug: name.parameterize) && new_record?

    errors.add(:name, 'already exists in the scope of this course. Please choose a different name.')
  end
end
