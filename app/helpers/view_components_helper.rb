module ViewComponentsHelper
  def button_component(path:, label: nil, size: nil, type: nil, icon_name: nil)
    render ButtonComponent.new(label:, path:, size:, type:, icon_name:)
  end

  def modal_button_component(path:, label: nil, size: nil, type: nil, icon_name: nil)
    render ModalButtonComponent.new(label:, path:, size:, type:, icon_name:)
  end
end
