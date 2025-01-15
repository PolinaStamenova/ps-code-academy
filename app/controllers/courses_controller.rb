class CoursesController < ApplicationController
  before_action :set_course, only: %i[show purchase]

  def index
    @courses = Course.active
  end

  def show; end

  def purchase; end

  private

  def set_course
    @course = Course.active.includes(:user).find_by!(slug: params[:id])
  end
end
