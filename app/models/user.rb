class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums
  enum role: { student: 0, admin: 1 }

  # Associations
  has_many :courses, dependent: :destroy
  # TODO: if user deleted update purchase.user to nil
  has_many :purchases

  # Validations
  validates :first_name, :last_name,
            presence: true,
            length: { minimum: 2 },
            format: { with: /\A[a-zA-Z\-']+\z/, message: 'only allows letters' }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Methods
  def admin?
    role == 'admin'
  end

  def student?
    role == 'student'
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
