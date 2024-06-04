class BandsController < ApplicationController
  def index
    @bands = policy_scope()
  end

  def show
    @band = Band.find(params[:id])
    authorize @band
  end

  def new
    @band = Band.new
    authorize @band
  end

  def create
    @band = Band.new(band_params)
    @band.user = current_user
    authorize @band
    if @band.save
      redirect_to mybands_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def mybands
    @band = Band.new
    @bands = Band.where(user: current_user)
    authorize @bands
  end

  def destroy
    raise
    @band = Band.find(params[:id])
    if @band.destroy
      redirect_to mybands_path
    else
      render :new, status: :see_other
    end
  end

  private

  def band_params
    params.require(:band).permit(:name, :photo, :user_id)
  end

end
