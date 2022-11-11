require 'rails_helper'

RSpec.describe InvitationSender do
  subject(:invitation_sender) { described_class.new(sender, recipient, team) }

  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:team) { create(:team) }

  before do
    create(:team_user, user: sender, team: team)
  end

  describe '#valid?' do
    describe 'when invitation is valid' do
      it { expect(invitation_sender.valid?).to eq(true) }
    end

    describe 'when recipient is already a member' do
      before do
        create(:team_user, user: recipient, team: team)
      end

      it 'is not valid' do
        expect(invitation_sender.valid?).to eq(false)
      end

      it 'adds an error message' do
        invitation_sender.valid?
        expect(invitation_sender.error_messages).to include('Recipient is already a team member')
      end
    end

    describe 'when recipient has already an active invitation' do
      before do
        create(:invitation, sender: sender, recipient: recipient, team: team, active: true)
      end

      it 'is not valid' do
        expect(invitation_sender.valid?).to eq(false)
      end

      it 'adds an error message' do
        invitation_sender.valid?
        expect(invitation_sender.error_messages).to include('Recipient has already an active invitation')
      end
    end

    describe 'when sender self-invited' do
      let(:recipient) { sender }

      it 'is not valid' do
        expect(invitation_sender.valid?).to eq(false)
      end

      it 'adds an error message' do
        invitation_sender.valid?
        expect(invitation_sender.error_messages).to include("Sender can't send an invitation to itself")
      end
    end
  end

  describe '#create' do
    it 'returns invitation created' do
      expect(invitation_sender.create).to be_a(Invitation)
    end
  end
end
