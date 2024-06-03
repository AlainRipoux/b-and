class BandsController < ApplicationController

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.create(band_params)
    @band.user = current_user
    if @band.save
      redirect_to mybands_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def mybands
    @band = Band.new
    @bands = Band.where(user: current_user)
  end

  private

  def band_params
    params.require(:band).permit(:name, :photo, :user_id)
  end

end
