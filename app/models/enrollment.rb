class Enrollment < ApplicationRecord
  # Enums
  enum status: { not_started: 0, started: 1, completed: 3 }

  # Associations
  belongs_to :user
  belongs_to :course

  def calculate_progress
    # TODO: Implement logic

    # total_lessons = course.lessons.count
    # completed_lessons = CompletedLesson.where(user:, lesson: course.lessons).count

    # if total_lessons.zero?
    #   0.0
    # else
    #   ((completed_lessons.to_f / total_lessons) * 100).round(2)
    # end
  end
end
