FactoryBot.define do
  factory :team do
    name { Faker::Game.title }
  end
end
