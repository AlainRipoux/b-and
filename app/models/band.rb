class Band < ApplicationRecord
  belongs_to :user
  has_many :users, through: :user_band
  has_many :events
  has_many :band_messages
end
