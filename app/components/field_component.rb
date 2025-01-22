class FieldComponent < ApplicationComponent
  attr_reader :name, :required

  def initialize(name:, placeholder:, required: false)
    super

    @name = name
    @placeholder = placeholder
    @required = required
  end

  def placeholder
    required? ? "* #{@placeholder}" : @placeholder
  end

  def required?
    required
  end

  class TextComponent < FieldComponent
    attr_reader :type

    def initialize(name:, placeholder:, required: false)
      super

      @type = :text_field
    end
  end

  class TextAreaComponent < FieldComponent
    attr_reader :type

    def initialize(name:, placeholder:, required: false)
      super

      @type = :text_area
    end
  end

  class RichTextAreaComponent < FieldComponent
    attr_reader :type

    def initialize(name:, placeholder:, required: false)
      super

      @type = :rich_text_area
    end
  end

  class TimeComponent < FieldComponent
    attr_reader :type, :value_in_hours, :value_in_minutes

    def initialize(name:, placeholder:, required: false, value_in_hours: 0, value_in_minutes: 0)
      super(name:, placeholder:, required:)

      @type = :time_field
      @value_in_hours = value_in_hours
      @value_in_minutes = value_in_minutes
    end
  end
end
