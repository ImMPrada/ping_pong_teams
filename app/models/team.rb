class Team < ApplicationRecord
  validates :name, presence: true

  has_one_attached :logo
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
end
