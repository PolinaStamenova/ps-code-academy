FactoryBot.define do
  factory :enrollment do
    user { create(:user) }
    course { create(:course, active: true) }
  end
end
