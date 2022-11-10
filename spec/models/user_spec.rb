require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:team_users) }
    it { is_expected.to have_many(:teams).through(:team_users) }
    it { is_expected.to have_many(:pings).dependent(:destroy) }
    it { is_expected.to have_many(:pongs).dependent(:destroy) }
  end
end
