require 'rails_helper'

RSpec.describe Team, type: :model do
  subject(:team) { build(:team) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_one_attached(:logo) }
    it { is_expected.to have_many(:team_users) }
    it { is_expected.to have_many(:users).through(:team_users) }
  end
end
