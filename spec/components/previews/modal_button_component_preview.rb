class ModalButtonComponentPreview < ViewComponent::Preview
  include ViewComponentsHelper

  # TODO: Fix modal to not render the new course form

  # Action button
  # @param label text "The text to display in the button"
  # @param path text "The path to navigate to when the button is clicked"
  # @param type text "The type of button to display: action, primary, danger"
  # @param size text "The size of the button: small, medium, large, large-xl"
  def default(label: 'Modal Button', path: new_admin_course_path, type: 'action', size: 'medium')
    modal_button_component(label:, path:, type:, size:)
  end

  # @!group With Icons

  # Action button with icon
  def add
    modal_button_component(label: 'Add button', path: '#', icon_name: 'add')
  end

  def edit
    modal_button_component(label: 'Edit button', path: '#', icon_name: 'edit')
  end

  def delete
    modal_button_component(label: 'Delete button', path: '#', icon_name: 'delete')
  end

  # @!endgroup

  # @!group Types

  # Button types options are: action, primary, danger
  def action
    modal_button_component(label: 'Action Button', path: '#', type: 'action')
  end

  def primary
    modal_button_component(label: 'Primary Button', path: '#', type: 'primary')
  end

  def danger
    modal_button_component(label: 'Danger Button', path: '#', type: 'danger')
  end

  # @!endgroup

  # @!group Sizes

  # Button sizes options are: small, medium, large, large-xl
  def small
    modal_button_component(label: 'Action Button', path: '#', size: 'small')
  end

  def medium
    modal_button_component(label: 'Action Button', path: '#', size: 'medium')
  end

  def large
    modal_button_component(label: 'Action Button', path: '#', size: 'large')
  end

  def large_xl
    modal_button_component(label: 'Action Button', path: '#', size: 'large-xl')
  end

  # @!endgroup
end
