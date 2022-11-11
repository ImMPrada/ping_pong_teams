require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  subject(:team_user) { build(:team_user) }

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:team) }
  end

  describe 'Validations' do
    it { is_expected.to validate_inclusion_of(:role).in_array(TeamUser::ROLES.values) }
  end
end
