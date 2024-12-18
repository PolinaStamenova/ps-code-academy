require 'rails_helper'

RSpec.describe FormComponent, type: :component do
  it 'renders the form' do
    course = Course.new

    render_inline(FormComponent.new(
                    resource: course,
                    action: '#',
                    method: :post
                  )) do |c|
      c.with_text_field(name: :name, placeholder: 'Name')
    end

    expect(page).to have_selector('form')
    expect(page).to have_field('Name')
  end
end
