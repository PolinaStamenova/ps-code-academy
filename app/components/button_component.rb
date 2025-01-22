class ButtonComponent < ApplicationComponent
  attr_reader :path, :method, :label, :type, :size, :icon_name, :disabled

  # TODO: Allow passing of htm opions(like disabled, ect.)
  def initialize(path:, method: nil, type: nil, label: nil, # rubocop:disable Metrics/ParameterLists
                 size: nil, icon_name: nil, disabled: nil)
    super

    @path = path
    @method = method || :get
    @label = label || ''
    @type = type || 'action'
    @size = size || 'medium'
    @icon_name = icon_name
    @disabled = disabled || false
  end

  private

  def default_classes
    'rounded-3xl p-2 text-center'
  end

  def full_classes
    base_classes = [default_classes, size_classes]

    base_classes << if @disabled
                      'text-slate-400	bg-gray-300 hover:shadow-none border-white'
                    else
                      "#{colors} hover:shadow-xl"
                    end
    base_classes.join(' ').strip
  end

  def colors
    color_classes = {
      'action' => 'bg-black text-white',
      'primary' => 'bg-white text-black border border-black hover:bg-gray-200',
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
      'back' => 'fas fa-arrow-left',
      'dollar' => 'fas fa-dollar-sign',
      'publish' => 'fas fa-upload'
    }

    icon_classes[@icon_name]
  end

  def button_content_classes
    'flex justify-center items-center gap-2' if icon_name.present? && label.present?
  end

  def icon_tag
    tag.i(class: icon_classes)
  end
end
