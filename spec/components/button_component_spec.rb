require 'rails_helper'

RSpec.describe ButtonComponent, type: :component do
  it 'renders button with text' do
    render_inline(ButtonComponent.new(label: 'New Record', type: :action, path: '#'))

    expect(page).to have_button('New Record')
  end
end
