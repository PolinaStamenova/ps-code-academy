class Admin::CourseModulesController < Admin::ApplicationController
  before_action :set_course
  before_action :set_course_module, only: %i[show edit update destroy]

  def new
    @course_module = CourseModule.new
  end

  def edit; end

  def create
    @course_module = @course.course_modules.build(course_module_params)

    if @course_module.save
      redirect_back(fallback_location: [:admin, @course],
                    notice: 'Course module was successfully created.')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @course_module.update(course_module_params)
      redirect_back(fallback_location: [:admin, @course],
                    notice: 'Course module was successfully updated.')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @course_module.destroy
      redirect_back(fallback_location: [:admin, @course],
                    notice: 'Course module was successfully destroyed.', status: :ok)
    else
      redirect_back(fallback_location: [:admin, @course],
                    alert: "Course module couldn't be destroyed.", status: :unprocessable_entity)
    end
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
