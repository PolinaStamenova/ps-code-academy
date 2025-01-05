require 'rails_helper'

RSpec.describe ModalComponent, type: :component do
  it 'renders the modal' do
    render_inline(ModalComponent.new) do |c|
      c.with_header(title: 'Title', context: 'Some text')

      'Body'
    end

    expect(page).to have_content('Title')
    expect(page).to have_content('Some text')
    expect(page).to have_content('Body')
  end

  it 'renders the modal with form' do
    course = Course.new

    form_content = render_inline(FormComponent.new(
                                   resource: course,
                                   action: '#',
                                   method: :post
                                 )) do |f|
      f.with_text_field(name: :name, placeholder: 'Name')
    end

    render_inline(ModalComponent.new) do |c|
      c.with_header(title: 'Title', context: 'Some text')

      form_content.to_s.html_safe
    end

    expect(page).to have_content('Title')
    expect(page).to have_content('Some text')
    expect(page).to have_selector('form')
    expect(page).to have_field('Name')
  end
end
