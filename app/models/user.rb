class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bands, dependent: :destroy
  has_many :user_bands, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :unavailabilities, dependent: :destroy
  has_many :band_messages, dependent: :destroy
  has_many :messages, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
