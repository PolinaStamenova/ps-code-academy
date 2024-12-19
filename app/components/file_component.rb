class FileComponent < ApplicationComponent
  attr_reader :form, :description

  def initialize(form: nil, description: 'Upload video')
    super

    @form = form
    @description = description
  end

  # TODO: Implement better UI for file upload
  class DocumentComponent < FileComponent
    def call
      content_tag(:div, class: 'form-component-file') do
        file_field_tag(:file, class: 'form-component-file-input')
      end
    end
  end

  class VideoComponent < FileComponent
  end
end
