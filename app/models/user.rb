class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users
end
