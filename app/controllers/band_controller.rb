class BandController < ApplicationController

  def show
    @band = Band.find(params[:band_id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.create(band_params)
    @band.user = current_user
    if @band.save
      redirect_to user_band(@band)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def mybands
    @bands = Band.where(user: current_user)
  end

  private

  def band_params
    params.require(:band).permit(:name, :photo, :user_id)
  end

end
