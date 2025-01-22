class ModalDeleteButtonComponent < ApplicationComponent
  attr_reader :label, :path, :size, :disabled, :type

  def initialize(path:, label: nil, size: nil, disabled: nil, type: nil)
    super

    @label = label
    @path = path
    @size = size
    @disabled = disabled || false
    @type = type
  end
end
