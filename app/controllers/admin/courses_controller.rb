module Admin
  class CoursesController < Admin::ApplicationController
    before_action :set_course, only: %i[show edit update destroy]

    def index
      @courses = current_user.courses.includes(course_modules: :module_lessons)
    end

    def show; end

    def new
      @course = Course.new
    end

    def create
      @course = Course.new(course_params)
      @course.user = current_user

      if @course.save
        redirect_to admin_course_path(@course)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @course.update(course_params)
        redirect_to admin_course_path(@course)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @course.destroy

      redirect_to admin_courses_path
    end

    private

    def course_params
      params.require(:course).permit(:name, :description)
    end

    def set_course
      @course = current_user.courses.find_by!(slug: params[:id])
    end
  end
end