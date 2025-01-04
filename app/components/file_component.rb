class FileComponent < ApplicationComponent
  attr_reader :form, :description

  def initialize(form: nil, description: '')
    super

    @form = form
    @description = description
  end

  # TODO: Implement better UI for file upload
  class DocumentComponent < FileComponent
    def initialize(form: nil, description: 'Upload Files')
      super
    end
  end

  class VideoComponent < FileComponent
    def initialize(form: nil, description: 'Upload Video')
      super
    end
  end

  class ImageComponent < FileComponent
    def initialize(form: nil, description: 'Upload Cover Image')
      super
    end
  end
end
