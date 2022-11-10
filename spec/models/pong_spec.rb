require 'rails_helper'

RSpec.describe Pong, type: :model do
  subject(:pong) { build(:pong) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:ping) }
  end
end
