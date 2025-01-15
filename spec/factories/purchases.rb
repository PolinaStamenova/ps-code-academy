FactoryBot.define do
  factory :purchase do
    user { create(:user) }
    item { create(:course, user: create(:user_admin), active: true) }
    quantity { 1 }
  end
end
