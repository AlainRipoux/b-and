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
  has_many :invites, class_name: "Invite", foreign_key: "second_user_id", dependent: :destroy
  has_many :invites_sent, class_name: "Invite", foreign_key: "first_user_id", dependent: :destroy
  has_many :pending_invites, -> { where status: "pending" }, class_name: "Invite", foreign_key: "second_user_id", dependent: :destroy
  geocoded_by :address

  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
