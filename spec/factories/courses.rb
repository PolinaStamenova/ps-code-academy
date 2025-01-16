FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph }

    user { create(:user) }
  end

  factory :course_with_video, parent: :course do
    video { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'video.mp4'), 'video/mp4') }
  end

  factory :active_course, parent: :course do
    active { true }
    published_at { 2.days.ago }
  end

  factory :enrolled_course, parent: :active_course do
    after(:create) do |course|
      Enrollment.create!(user: course.user, course:)
    end
  end

  factory :course_not_started, parent: :enrolled_course do
    after(:create) do |course|
      course.enrollment.update!(status: :not_started)
    end
  end

  factory :course_started, parent: :enrolled_course do
    after(:create) do |course|
      course.enrollment.update!(status: :started)
    end
  end

  factory :course_completed, parent: :enrolled_course do
    after(:create) do |course|
      course.enrollment.update!(status: :completed)
    end
  end

  factory :course_with_one_course_module, parent: :course do
    after(:create) do |course|
      create(:course_module, course:)
    end
  end
end
