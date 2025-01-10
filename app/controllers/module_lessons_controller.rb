class ModuleLessonsController < ApplicationController
  def show
    # TODO: Fix N+1 queries & Courses that have been enrolled by the user
    @course = Course.find_by!(slug: params[:course_id])
    @course_module = @course.course_modules.find_by!(slug: params[:course_module_id])
    @module_lesson = @course_module.module_lessons.find_by!(slug: params[:id])
  end
end
