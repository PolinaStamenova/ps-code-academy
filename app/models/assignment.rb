class Assignment < ApplicationRecord
  # Attributes
  attr_accessor :estimated_time_in_minutes_hours, :estimated_time_in_minutes_minutes

  # Associations
  belongs_to :course_module

  # ActionText
  has_rich_text :content

  # Validations
  validates :name, presence: true
  validates :content, presence: true

  validate :validate_github_repo_link_format

  def estimated_time_in_hours
    self[:estimated_time_in_minutes].nil? ? nil : (self[:estimated_time_in_minutes] / 60)
  end

  private

  def validate_github_repo_link_format
    return if github_repo_link.blank?
    return if github_repo_link&.match?(%r{\Ahttps://github.com/[^/]+/[^/]+\z})

    errors.add(:github_repo_link, 'is invalid. Please provide a valid GitHub repository link.')
  end
end
