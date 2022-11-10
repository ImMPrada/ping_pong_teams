class Pong < ApplicationRecord
  belongs_to :user
  belongs_to :ping
end
