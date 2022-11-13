class Ping < ApplicationRecord
  belongs_to :user
  belongs_to :team

  has_many :pongs, dependent: :destroy

  def suscribed_pongs
    pongs.where(active: true)
  end
end
