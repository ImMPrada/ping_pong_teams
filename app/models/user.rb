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
end
