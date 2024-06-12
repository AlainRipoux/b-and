class Unavailability < ApplicationRecord
  belongs_to :user

  # def start_time
  #   self.Unavailability.start ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  # end
end
