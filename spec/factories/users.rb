FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name.gsub('.', '') }
    last_name { Faker::Name.last_name.gsub('.', '') }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :user_admin, parent: :user do
    role { 'admin' }
  end
end
