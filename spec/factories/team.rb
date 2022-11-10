FactoryBot.define do
  factory :team do
    name { Faker::Game.title }
    logo { Rack::Test::UploadedFile.new('spec/fixtures/images/team_logo.png', 'image/png') }
  end
end
