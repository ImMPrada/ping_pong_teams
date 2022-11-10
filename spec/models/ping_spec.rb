require 'rails_helper'

RSpec.describe Ping, type: :model do
  subject(:ping) { build(:ping) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:team) }
    it { is_expected.to have_many(:pongs).dependent(:destroy) }
  end
end
