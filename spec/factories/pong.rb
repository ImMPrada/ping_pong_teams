FactoryBot.define do
  factory :pong do
    association :ping
    association :user
    active { [true, false].sample }
  end
end
