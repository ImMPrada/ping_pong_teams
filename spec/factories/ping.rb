FactoryBot.define do
  factory :ping do
    association :team
    association :user
  end
end
