require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  subject(:team_user) { build(:team_user) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:team) }
  end
end
