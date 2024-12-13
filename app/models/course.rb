class Course < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :course_modules, dependent: :destroy

  has_one_attached :video

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

    return unless Course.exists?(slug: name.parameterize) && new_record?

    errors.add(:name, 'has already been taken. Please choose a different name.')
  end
end
