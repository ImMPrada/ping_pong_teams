FactoryBot.define do
  factory :ping do
    association :team
    association :user
    active { [true, false].sample }
  end
end
