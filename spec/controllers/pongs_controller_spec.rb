require 'rails_helper'

RSpec.describe PongsController, type: :controller do
  let(:user) { create(:user, teams: [team]) }
  let(:team) { create(:team) }
  let(:ping) { create(:ping, team: team, active: true) }

  before do
    sign_in user
  end

  describe '#create' do
    before do
      post :create, params: { ping_id: ping.id }
    end

    it 'creates a pong' do
      expect(Pong.last).to be_present
    end
  end

  describe '#update' do
    let(:pong) { create(:pong, user: user, ping: ping, active: true) }

    before do
      patch :update, params: { id: pong.id, active: false }
    end

    it "updates the pong's active status to false" do
      expect(Pong.last.active).to be(false)
    end
  end
end
