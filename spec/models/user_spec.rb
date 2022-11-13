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
    it { is_expected.to have_many(:sent_invitations).class_name('Invitation').with_foreign_key(:sender_id) }
    it { is_expected.to have_many(:received_invitations).class_name('Invitation').with_foreign_key(:recipient_id) }
  end

  describe '#become_owner_of!' do
    subject(:user) { create(:user, teams: [team]) }

    let(:team) { create(:team) }
    let(:team_user) { TeamUser.find_by(user: user, team: team) }

    before do
      user.become_owner_of!(team)
    end

    it 'becomes the user an owner of the team' do
      expect(team_user.role).to eq(TeamUser::ROLES[:owner])
    end
  end

  describe '#suscribed_to_team_ping?' do
    subject(:user) { create(:user, teams: [team]) }

    let(:team) { create(:team) }
    let(:ping) { create(:ping, team: team, active: true) }

    before do
      create(:pong, ping: ping, user: user, active: true)
    end

    it 'returns true if the user is suscribed to the team ping' do
      expect(user.suscribed_to_team_ping?(team)).to be(true)
    end
  end
end
