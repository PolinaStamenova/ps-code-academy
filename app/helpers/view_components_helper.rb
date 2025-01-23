module ViewComponentsHelper
  def button_component(path:, method: nil, label: nil, size: nil, type: nil, icon_name: nil, disabled: nil) # rubocop:disable Metrics/ParameterLists
    render ButtonComponent.new(label:, path:, method:, size:, type:, icon_name:, disabled:)
  end

  def modal_button_component(path:, method: nil, label: nil, size: nil, type: nil, icon_name: nil, disabled: nil) # rubocop:disable Metrics/ParameterLists
    render ModalButtonComponent.new(label:, path:, method:, size:, type:, icon_name:, disabled:)
  end

  def modal_delete_button_component(path:, label: nil, size: nil, disabled: nil)
    render ModalDeleteButtonComponent.new(label:, path:, size:, disabled:)
  end
end
