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
      c.with_video(form: c, description: 'Upload your video')
      c.with_document(form: c, description: 'Upload your document')
    end

    expect(page).to have_selector('form')
    expect(page).to have_field('Name')
    expect(page).to have_field('video-upload')
    expect(page).to have_selector('span', text: 'Upload your video')
    expect(page).to have_selector('span', text: 'Upload your document')
  end
end
