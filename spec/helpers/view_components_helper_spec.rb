require 'rails_helper'

RSpec.describe ViewComponentsHelper, type: :helper do
  describe '#button_component' do
    it 'renders the ButtonComponent with the correct label in the view' do
      result = helper.button_component(
        path: '#',
        label: 'Test Button',
        size: 'medium',
        type: 'action',
        icon_name: 'add'
      )
      expect(result).to include('Test Button')
    end
  end

  describe '#modal_button_component' do
    it 'renders the ModalButtonComponent with the correct label in the view' do
      result = helper.modal_button_component(
        path: '#',
        label: 'Test Modal Button',
        size: 'medium',
        type: 'action',
        icon_name: 'add'
      )
      expect(result).to include('Test Modal Button')
    end
  end
end
