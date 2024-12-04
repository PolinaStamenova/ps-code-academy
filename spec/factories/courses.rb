FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }

    user { create(:user) }
  end

  factory :course_with_video, parent: :course do
    video { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'video.mp4'), 'video/mp4') }
  end

  factory :course_with_one_course_module, parent: :course do
    after(:create) do |course|
      create(:course_module, course:)
    end
  end
end
