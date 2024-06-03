class BandMessage < ApplicationRecord
  belongs_to :band
  belongs_to :user
end
