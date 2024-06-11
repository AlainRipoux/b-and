class Document < ApplicationRecord
  belongs_to :band
  has_one_attached :file
end
