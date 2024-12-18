class FieldComponent < ApplicationComponent
  attr_reader :name, :placeholder

  def initialize(name:, placeholder:)
    super

    @name = name
    @placeholder = placeholder
  end

  class TextComponent < FieldComponent
    attr_reader :type

    def initialize(name:, placeholder:)
      super

      @type = :text_field
    end
  end

  class TextAreaComponent < FieldComponent
    attr_reader :type

    def initialize(name:, placeholder:)
      super

      @type = :text_area
    end
  end
end
