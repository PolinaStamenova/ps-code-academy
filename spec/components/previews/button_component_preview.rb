class ButtonComponentPreview < ViewComponent::Preview
  include ViewComponentsHelper

  # Action button
  # @param label text "The text to display in the button"
  # @param path text "The path to navigate to when the button is clicked"
  # @param method text "The HTTP method to use when navigating to the path"
  # @param type text "The type of button to display: action, primary, danger"
  # @param size text "The size of the button: small, medium, large, large-xl"
  def default(label: 'Click here', path: '#', method: :get, type: 'action', size: 'medium')
    button_component(label:, path:, method:, type:, size:)
  end

  # Disabled button
  # @param disabled text "Disable the button"
  def disabled(label: 'Disabled', path: '#', type: 'action', size: 'medium', disabled: true)
    button_component(label:, path:, type:, size:, disabled:)
  end

  # @!group With Icons

  # Button icon_names options are: add, edit, delete, back
  def add
    button_component(label: 'Add button', path: '#', icon_name: 'add')
  end

  def edit
    button_component(label: 'Edit button', path: '#', icon_name: 'edit')
  end

  def delete
    button_component(label: 'Delete button', path: '#', icon_name: 'delete')
  end

  def back
    button_component(label: 'Back button', path: '#', icon_name: 'back')
  end

  # @!endgroup

  # @!group Types

  # Button types options are: action, primary, danger
  def action
    button_component(label: 'Action Button', path: '#', type: 'action')
  end

  def primary
    button_component(label: 'Primary Button', path: '#', type: 'primary')
  end

  def danger
    button_component(label: 'Danger Button', path: '#', type: 'danger')
  end

  # @!endgroup

  # @!group Sizes

  # Button sizes options are: small, medium, large, large-xl
  def small
    button_component(label: 'Action Button', path: '#', size: 'small')
  end

  def medium
    button_component(label: 'Action Button', path: '#', size: 'medium')
  end

  def large
    button_component(label: 'Action Button', path: '#', size: 'large')
  end

  def large_xl
    button_component(label: 'Action Button', path: '#', size: 'large-xl')
  end

  # @!endgroup
end
