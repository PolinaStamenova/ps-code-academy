class CoursesController < ApplicationController
  def index
    @courses = Course.active
  end

  def show
    @course = Course.find_by!(slug: params[:id])
  end
end
