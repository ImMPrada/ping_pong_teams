FactoryBot.define do
  factory :invitation do
    association :sender, factory: :user
    association :recipient, factory: :user
    association :team
    active { [true, false].sample }
    accepted { [true, false, nil].sample }
  end
end
