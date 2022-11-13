class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users
  has_many :pings, dependent: :destroy
  has_many :pongs, dependent: :destroy
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: :sender_id, inverse_of: :sender,
                              dependent: :destroy
  has_many :received_invitations, class_name: 'Invitation', foreign_key: :recipient_id, inverse_of: :recipient,
                                  dependent: :destroy

  def become_owner_of!(team)
    team_user = team_users.find_by(team: team)
    team_user.update!(role: TeamUser::ROLES[:owner])
  end

  def member_of?(team)
    teams.include?(team)
  end

  def suscribed_to_team_ping?(team)
    team.active_ping.pongs.where(user: self, active: true).any?
  end
end
