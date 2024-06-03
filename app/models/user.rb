class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :band
  has_many :bands, through: :user_band
  has_many :events
  has_many :tasks
  has_many :unavailabilities
  has_many :band_messages
  has_many :messages

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
