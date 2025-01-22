require 'rails_helper'

RSpec.describe ModalDeleteButtonComponent, type: :component do
  it 'renders the component' do
    render_inline(ModalButtonComponent.new(label: 'Delete', path: '#'))

    expect(page).to have_button('Delete')
  end
end
