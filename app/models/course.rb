class Course < ApplicationRecord
  # Associations
  belongs_to :user

  has_one_attached :video

  # Validations
  validates :name, presence: true
end
