require 'rails_helper'

RSpec.describe ModalButtonComponent, type: :component do
  it 'renders the modal button with text' do
    render_inline(ModalButtonComponent.new(label: 'New Record', type: :action, path: '#'))

    expect(page).to have_button('New Record')
  end
end
