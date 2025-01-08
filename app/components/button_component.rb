class ButtonComponent < ApplicationComponent
  attr_reader :path, :label, :type, :size, :icon_name

  def initialize(path:, type: nil, label: nil, size: nil, icon_name: nil)
    super

    @path = path
    @label = label || ''
    @type = type || 'action'
    @size = size || 'medium'
    @icon_name = icon_name
  end

  def default_classes
    # Add gap-3 class only if there is a label (icon-only buttons should not have gap-3)
    classes = 'border rounded-3xl p-2 hover:shadow-xl text-center flex justify-center items-center'

    if @label.present?
      [classes, 'gap-3'].join(' ').strip if @label.present?
    else
      classes
    end
  end

  def full_classes
    [default_classes, colors, size_classes].join(' ').strip
  end

  def colors
    color_classes = {
      'action' => 'bg-black text-white',
      'primary' => 'bg-white text-black border-black hover:bg-gray-200',
      'danger' => 'bg-red-600 text-black'
    }

    color_classes[@type]
  end

  def size_classes
    size_classes = {
      'xs-small' => 'w-9 text-xs',
      'x-small' => 'w-20 text-xs',
      'small' => 'w-40 text-sm',
      'medium' => 'w-60',
      'large' => 'w-80 text-lg',
      'large-xl' => 'w-100 text-xl'
    }

    size_classes[@size]
  end

  def icon_classes
    icon_classes = {
      'add' => 'fas fa-plus',
      'edit' => 'fas fa-edit',
      'delete' => 'fas fa-trash',
      'back' => 'fas fa-arrow-left'
    }

    icon_classes[@icon_name]
  end
end
