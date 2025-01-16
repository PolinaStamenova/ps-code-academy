class CoursesController < ApplicationController
  before_action :set_course, only: %i[show purchase]

  def index
    @current_filter = params[:filter] || 'all'
    @courses = filtered_by_enrollment

    @courses.order(published_at: :desc)
  end

  def show; end

  def purchase; end

  def enrolled
    @current_filter = params[:filter] || 'all'
    @courses = filtered_by_status

    @courses.order('enrollments.created_at ASC')
  end

  private

  def set_course
    @course = Course.active.includes(:user).find_by!(slug: params[:id])
  end

  def filtered_by_enrollment
    case params[:filter]
    when 'enrolled'
      current_user.enrolled_courses
    when 'not_enrolled'
      Course.active.where.not(id: current_user.enrolled_courses.pluck(:id))
    else
      Course.active
    end
  end

  def filtered_by_status
    case params[:filter]
    when 'not_started'
      current_user.not_started_courses
    when 'started'
      current_user.started_courses
    when 'completed'
      current_user.completed_courses
    else
      current_user.enrolled_courses
    end
  end
end
