class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  ROLES = {
    owner: 'owner',
    member: 'member'
  }.freeze

  validates :role, inclusion: { in: ROLES.values }
end
