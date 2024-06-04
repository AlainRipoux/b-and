class Band < ApplicationRecord
  belongs_to :user
  has_many :user_bands
  has_many :users, through: :user_bands
  has_many :events
  has_many :band_messages
  has_many :tasks
  has_one_attached :photo

end
