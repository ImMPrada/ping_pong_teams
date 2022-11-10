require 'rails_helper'

RSpec.describe Team, type: :model do
  subject(:team) { build(:team) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
