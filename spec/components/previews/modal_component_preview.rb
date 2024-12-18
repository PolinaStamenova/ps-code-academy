class ModalComponentPreview < ViewComponent::Preview
  def default
    # TODO: Fix preview

    render ModalComponent.new do |component|
      component.with_header(title: 'Modal Title', context: 'Modal Context')
    end
  end
end
