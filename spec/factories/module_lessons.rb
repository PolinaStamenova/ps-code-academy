FactoryBot.define do
  factory :module_lesson do
    name { Faker::Educator.course_name }

    course { create(:course_module) }
  end

  factory :module_lesson_with_video, parent: :module_lesson do
    video { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'video.mp4'), 'video/mp4') }
  end

  factory :module_lesson_with_documents, parent: :module_lesson do
    documents { [fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'document.pdf'), 'application/pdf')] }
  end
end
