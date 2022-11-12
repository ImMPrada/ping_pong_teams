require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  let(:user) { create(:user, teams: [team]) }
  let(:team) { create(:team) }

  before do
    sign_in user
  end

  describe '#new' do
    before do
      get :new, params: { team_id: team.id }
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    let(:recipient) { create(:user) }
    let(:params) do
      {
        team_id: team.id,
        username: recipient.username
      }
    end
    let(:invitation) { create(:invitation, sender: user, recipient: recipient, team: team, active: true) }
    let(:invitation_sender) { instance_double(InvitationSender, valid?: true, create: invitation) }

    before do
      allow(InvitationSender).to receive(:new).and_return(invitation_sender)

      post :create, params: params
    end

    it 'calls InvitationSender to validate' do
      expect(invitation_sender).to have_received(:valid?)
    end

    it 'calls InvitationSender to create the invitation' do
      expect(invitation_sender).to have_received(:create)
    end

    it 'redirects to the teams page' do
      expect(response).to redirect_to(teams_path)
    end

    describe 'when InvitationSender is invalid' do
      let(:invitation_sender) { instance_double(InvitationSender, valid?: false, error_messages: ['error']) }

      it 'sets an alert flash message' do
        expect(flash[:error]).to eq('error')
      end

      it 'redirects to the new team invitation page' do
        expect(response).to redirect_to(new_team_invitation_path(team))
      end
    end
  end
end
