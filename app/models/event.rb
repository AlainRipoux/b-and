class Event < ApplicationRecord
  belongs_to :band
  belongs_to :user

  has_one_attached :photo
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def start_time
    self.start_date
  end

  def end_time
    self.end_date
  end
end
