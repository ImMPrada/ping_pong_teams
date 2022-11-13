require 'rails_helper'

RSpec.describe Ping, type: :model do
  subject(:ping) { build(:ping) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:team) }
    it { is_expected.to have_many(:pongs).dependent(:destroy) }
  end

  describe '#suscribed_pongs' do
    before do
      create(:pong, ping: ping, active: true)
      create(:pong, ping: ping, active: true)
    end

    it 'returns all pongs with active true' do
      expect(ping.suscribed_pongs.count).to eq(2)
    end
  end
end
