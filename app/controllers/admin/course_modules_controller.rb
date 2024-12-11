class Admin::CourseModulesController < Admin::ApplicationController
  before_action :set_course
  before_action :set_course_module, only: %i[show edit update destroy]

  def index
    @course_modules = current_user.courses.find_by!(slug: params[:course_id]).course_modules
  end

  def show; end

  def new
    @course_module = CourseModule.new
  end

  def edit; end

  def create
    @course_module = @course.course_modules.build(course_module_params)

    if @course_module.save
      redirect_to [:admin, @course, @course_module], notice: 'Course module was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @course_module.update(course_module_params)
      redirect_to [:admin, @course, @course_module], notice: 'Course module was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course_module.destroy

    redirect_to admin_course_course_modules_path(@course), notice: 'Course module was successfully destroyed.'
  end

  private

  def set_course
    @course = current_user.courses.find_by!(slug: params[:course_id])
  end

  def set_course_module
    @course_module = @course.course_modules.find_by!(slug: params[:id])
  end

  def course_module_params
    params.require(:course_module).permit(:name, :description)
  end
end
