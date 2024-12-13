class FormComponentPreview < ViewComponent::Preview
  # Preview the form with fields for a Course
  def default
    course = Course.new(name: 'Example Course', description: 'A sample course description')

    render(FormComponent.new(resource: course, action: '#', method: :post)) do |form|
      form.with_text_field(name: :name, placeholder: 'Name')
      form.with_text_area_field(name: :description, placeholder: 'Description')

      form.with_submit label: 'Create Course'
    end
  end

  def with_errors
    course = Course.new(name: '', description: 'A sample description')
    course.errors.add(:name, 'cannot be blank')

    render(FormComponent.new(resource: course, action: '#', method: :post)) do |form|
      form.with_text_field(name: :name, placeholder: 'Name')
      form.with_text_area_field(name: :description, placeholder: 'Description')
    end
  end

  def update
    course = Course.new(name: 'Example Course', description: 'A sample description')

    render(FormComponent.new(resource: course, action: '#', method: :patch)) do |form|
      form.with_text_field(name: :name, placeholder: 'Name')
      form.with_text_area_field(name: :description, placeholder: 'Description')

      form.with_submit label: 'Update Course'
    end
  end
end
