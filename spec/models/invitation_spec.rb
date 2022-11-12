require 'rails_helper'

RSpec.describe Invitation, type: :model do
  subject(:invitation) { build(:invitation) }

  describe 'Associations' do
    it { is_expected.to belong_to(:sender).class_name('User') }
    it { is_expected.to belong_to(:recipient).class_name('User') }
    it { is_expected.to belong_to(:team) }
  end
end
