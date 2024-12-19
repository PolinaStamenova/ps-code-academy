class FormComponent < ApplicationComponent
  attr_reader :resource, :action, :method

  def initialize(resource:, action:, method: :post)
    super

    @resource = resource
    @action = action
    @method = method
  end

  renders_many :fields, types: {
    text: { renders: FieldComponent::TextComponent, as: :text_field },
    text_area: { renders: FieldComponent::TextAreaComponent, as: :text_area_field }
  }

  renders_many :files, types: {
    file: { renders: FileComponent::DocumentComponent, as: :file }
  }

  renders_one :video, 'FileComponent::VideoComponent'

  renders_one :submit, 'SubmitComponent'

  def default_form_classes
    # TODO: Add classes to the form
  end

  def errors_class
    # TODO: Use TailwindCSS classes to style the errors
    'color: red; margin-bottom: 1rem'
  end

  class SubmitComponent < ApplicationComponent
    attr_reader :label, :classes

    def initialize(label: 'Submit', classes: 'form-component-submit-btn')
      super

      @label = label
      @classes = classes
    end

    def call
      content_tag(:input, nil, class: classes, type: 'submit', value: label)
    end
  end
end
