class ModalDeleteButtonComponentPreview < ViewComponent::Preview
  # **Modal Delete Button:**
  # Ensure to add **status: :ok** to the `redirect_to or redirect_back` method
  # in the destroy action for proper handling of successful deletions.
  # @param label text "The text to display in the button"
  # @param path text "Path to the delete action"
  # @param size text "The size of the button: small, medium, large, large-xl"
  # @param type text "The type of button to display: action, primary, danger"
  def default(label: 'Delete', path: '#', size: 'small', type: 'action')
    render ModalDeleteButtonComponent.new(label:, path:, size:, type:)
  end
end
