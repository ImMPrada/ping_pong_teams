FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }

    random_pwd = Faker::Internet.password
    password { random_pwd }
    password_confirmation { random_pwd }
  end
end
