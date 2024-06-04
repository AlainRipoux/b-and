class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_bands
  has_many :bands, through: :user_bands
  has_many :events
  has_many :tasks
  has_many :unavailabilities
  has_many :band_messages
  has_many :messages
  has_many :invites, class_name: "Invite", foreign_key: "second_user_id"
  has_many :pending_invites, -> { where status: "pending" }, class_name: "Invite", foreign_key: "second_user_id"

  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
