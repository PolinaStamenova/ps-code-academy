class Course < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  # Validations
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
