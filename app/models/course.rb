class Course < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :course_modules, dependent: :destroy

  has_one_attached :video

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

    return unless Course.exists?(slug: name.parameterize) && new_record?

    errors.add(:name, 'has already been taken. Please choose a different name.')
  end

  # TODO: Write spec
  def validate_video_format
    return unless video.attached?

    return if video.content_type.in?(%w[video/mp4 video/quicktime video/mov video/webm])

    errors.add(:video, 'must be a valid video format (mp4, mov, avi, or webm)')
  end
end
