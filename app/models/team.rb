class Team < ApplicationRecord
  DEFAULT_LOGO_URL = 'https://gravatar.com/avatar/4e029be73751a42795947ff5efb9c8cc?s=400&d=robohash&r=x'

  validates :name, presence: true

  has_one_attached :logo
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_many :pings, dependent: :destroy
end
