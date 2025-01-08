class Admin::ModuleLessonsController < Admin::ApplicationController
  before_action :set_course, :set_course_module
  before_action :set_module_lesson, only: %i[show edit update destroy]

  def index
    @module_lessons = @course_module.module_lessons
  end

  def show; end

  def new
    @module_lesson = ModuleLesson.new
  end

  def edit; end

  def create
    @module_lesson = @course_module.module_lessons.build(module_lesson_params)

    if @module_lesson.save
      redirect_back(fallback_location: [:admin, @course],
                    notice: 'Module lesson was successfully created.')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @module_lesson.update(module_lesson_params)
      redirect_back(fallback_location: [:admin, @course],
                    notice: 'Module lesson was successfully updated.')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @module_lesson.destroy

    redirect_to admin_course_course_module_path(@course, @course_module),
                notice: 'Module lesson was successfully destroyed.'
  end

  private

  def set_course
    @course = current_user.courses.find_by!(slug: params[:course_id])
  end

  def set_course_module
    @course_module = @course.course_modules.find_by!(slug: params[:course_module_id])
  end

  def set_module_lesson
    @module_lesson = @course_module.module_lessons.find_by!(slug: params[:id])
  end

  def module_lesson_params
    params.require(:module_lesson).permit(:name, :description, :video)
  end
end
