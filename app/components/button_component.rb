class ButtonComponent < ApplicationComponent
  attr_reader :path, :label, :type, :size, :icon_name

  def initialize(path:, type: nil, label: '', size: nil, icon_name: '')
    super

    @path = path
    @label = label || 'Click here'
    @type = type || 'action'
    @size = size || 'medium'
    @icon_name = icon_name
  end

  def default_classes
    'border rounded-3xl p-2 hover:shadow-xl text-center my-4'
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
      'delete' => 'fas fa-trash'
    }

    [icon_classes[@icon_name], 'pl-3'].join(' ').strip
  end
end
