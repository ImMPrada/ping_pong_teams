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
    it { is_expected.to have_many(:pings).dependent(:destroy) }
    it { is_expected.to have_many(:invitations) }
  end

  describe '#any_active_ping?' do
    describe 'when there are no active pings' do
      before do
        create(:ping, team: team, active: false)
      end

      it 'returns false' do
        expect(team.any_active_ping?).to eq(false)
      end
    end

    describe 'when there are active pings' do
      before do
        create(:ping, team: team, active: true)
      end

      it 'returns true' do
        expect(team.any_active_ping?).to eq(true)
      end
    end
  end

  describe '#active_ping' do
    before do
      create(:ping, team: team, active: true)
    end

    it 'returns the active ping' do
      expect(team.active_ping).to eq(Ping.last)
    end
  end
end
