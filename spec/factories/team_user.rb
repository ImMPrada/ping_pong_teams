FactoryBot.define do
  factory :team_user do
    association :team
    association :user

    role { TeamUser::ROLES.values.sample }
  end
end
