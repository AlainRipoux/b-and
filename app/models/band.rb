class Band < ApplicationRecord
  belongs_to :user
  has_many :user_bands, dependent: :destroy
  has_many :users, through: :user_bands
  has_many :tasks, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :band_messages, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_one_attached :photo

  validates :name, uniqueness: true, presence: true

end
