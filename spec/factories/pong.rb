FactoryBot.define do
  factory :pong do
    association :ping
    association :user
  end
end
