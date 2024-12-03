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
end
