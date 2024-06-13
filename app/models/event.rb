class Event < ApplicationRecord
  belongs_to :band
  belongs_to :user

  def start_time
    self.start_date
  end

  def end_time
    self.end_date
  end
end
