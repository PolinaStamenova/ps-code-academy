class ModalComponent < ApplicationComponent
  attr_reader :title

  def initialize(title: nil)
    super

    @title = title
  end

  renders_one :header, 'HeaderComponent'

  class HeaderComponent < ApplicationComponent
    attr_reader :title, :context

    def initialize(title: nil, context: nil)
      super

      @title = title
      @context = context
    end

    def call
      content_tag :div, class: 'flex flex-col gap-2 items-center text-center w-full mb-4 break-words' do
        safe_join([
                    content_tag(:h1, title, class: 'text-2xl font-bold'),
                    content_tag(:h5, context)
                  ])
      end
    end
  end
end
