class BandController < ApplicationController

  def mybands
    @bands = Band.where(user: current_user)
  end
end
