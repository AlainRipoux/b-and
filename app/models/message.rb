class Message < ApplicationRecord
  belongs_to :user
  belongs_to :invite

  validates :content, presence: true
end
