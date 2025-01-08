class ModuleLesson < ApplicationRecord
  # Constants
  VIDEO_FORMATS = %w[video/mp4 video/quicktime video/webm].freeze

  # Associations
  belongs_to :course_module

  has_one_attached :video
  has_many_attached :documents

  # Validations
  validates :name, presence: true
  validate :name_unique_as_slug
  validate :validate_video_format

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

    return unless course_module.module_lessons.exists?(slug: name.parameterize) && new_record?

    errors.add(:name, 'already exists in the scope of this course module. Please choose a different name.')
  end

  def validate_video_format
    return unless video.attached?

    return if video.content_type.in?(VIDEO_FORMATS)

    errors.add(:video, 'must be a valid video format (mp4, avi, or webm)')
  end
end
