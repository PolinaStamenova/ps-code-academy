class Course < ApplicationRecord
  # Constants
  VIDEO_FORMATS = %w[video/mp4 video/quicktime video/webm].freeze
  COVER_IMAGE_FORMATS = %w[image/png image/jpg image/jpeg].freeze

  # Associations
  belongs_to :user
  has_many :course_modules, dependent: :destroy
  has_many :purchases, foreign_key: :item_id
  # TODO: What happens if a course is deleted? Should we keep the enrollment?
  has_one :enrollment, dependent: :destroy

  # Active Storage
  has_one_attached :video
  has_one_attached :image

  # Validations
  validates :name, presence: true
  validate :name_unique_as_slug
  validate :validate_video_format
  validate :validate_image_format

  # Callbacks
  before_validation :set_slug

  # Scopes
  scope :active, -> { where(active: true) }
  scope :draft, -> { where(active: false) }

  def to_param
    slug
  end

  def price_in_cents
    # TODO: Add price in cents to the model
    # TODO: Implement a better way to handle prices
    (18 * 100).to_i
  end

  def enrolled?(user)
    enrollment&.user == user
  end

  def status
    enrollment&.status || 'Not enrolled'
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

  def validate_video_format
    return unless video.attached?

    return if video.content_type.in?(VIDEO_FORMATS)

    errors.add(:video, 'must be a valid video format (mp4, avi, or webm)')
  end

  def validate_image_format
    return unless image.attached?

    return if image.content_type.in?(COVER_IMAGE_FORMATS)

    errors.add(:image, 'must be a valid video format (png, jpg, or jpeg)')
  end
end
