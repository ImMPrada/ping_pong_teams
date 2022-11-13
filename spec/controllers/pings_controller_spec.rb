require 'rails_helper'

RSpec.describe PingsController, type: :controller do
  let(:user) { create(:user, teams: [team]) }
  let(:team) { create(:team) }

  before do
    sign_in user
  end

  describe '#create' do
    before do
      post :create, params: { team_id: team.id }
    end

    describe 'creates a Ping' do
      subject(:ping) { Ping.last }

      it 'belongs to the user' do
        expect(ping.user).to eq(user)
      end

      it 'belongs to the team' do
        expect(ping.team).to eq(team)
      end
    end

    describe 'creates a Pong' do
      subject(:pong) { Pong.last }

      let(:ping) { Ping.last }

      it 'belongs to the user' do
        expect(pong.user).to eq(user)
      end

      it 'belongs to the ping' do
        expect(pong.ping).to eq(ping)
      end
    end
  end
end
