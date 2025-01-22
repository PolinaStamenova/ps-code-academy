class Admin::AssignmentsController < Admin::ApplicationController
  before_action :set_course
  before_action :set_course_module, only: %i[new create]
  def new
    @assignment = Assignment.new
  end

  def create
    estimated_time_in_minutes = calculate_time_in_minutes(
      assignment_params[:estimated_time_in_minutes_hours],
      assignment_params[:estimated_time_in_minutes_minutes]
    )

    serialized_params = assignment_params.except(:estimated_time_in_minutes_hours, :estimated_time_in_minutes_minutes)

    @assignment = Assignment.new(
      serialized_params.merge(
        course_module_id: @course_module.id,
        estimated_time_in_minutes:
      )
    )

    if @assignment.save
      redirect_back(fallback_location: [:admin, @course],
                    notice: 'Assignment was successfully created.')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :content, :github_repo_link, :estimated_time_in_minutes_hours,
                                       :estimated_time_in_minutes_minutes)
  end

  def set_course
    @course = current_user.courses.find_by!(slug: params[:course_id])
  end

  def set_course_module
    @course_module = @course.course_modules.find_by!(slug: params[:course_module_id])
  end

  def calculate_time_in_minutes(hours, minutes)
    (hours.to_i * 60) + minutes.to_i
  end
end
