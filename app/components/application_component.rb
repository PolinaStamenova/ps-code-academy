class ApplicationComponent < ViewComponent::Base
  include ActionView::Helpers::FormHelper
  include Turbo::FramesHelper
  include ViewComponentsHelper

  # Solve undefined method 'rich_text_area_tag' for view_components
  # https://vchkhr.medium.com/how-to-solve-undefined-method-rich-text-area-tag-f0342b09d759
  delegate :rich_text_area_tag, to: :helpers
end
