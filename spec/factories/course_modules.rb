FactoryBot.define do
  factory :course_module do
    name { Faker::Educator.course_name }

    course { create(:course) }
  end

  factory :course_module_with_video, parent: :course_module do
    video { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'video.mp4'), 'video/mp4') }
  end

  factory :course_module_with_documents, parent: :course_module do
    documents { [fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'document.pdf'), 'application/pdf')] }
  end

  factory :course_module_with_lessons, parent: :course_module do
    transient do
      lessons_count { 5 }
    end

    after(:create) do |course_module, evaluator|
      create_list(:module_lesson, evaluator.lessons_count, course_module:)
    end
  end
end
