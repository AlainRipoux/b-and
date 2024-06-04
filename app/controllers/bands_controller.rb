class BandsController < ApplicationController
  def index
    @bands = policy_scope(Band)
  end

  def show
    @band = Band.find(params[:id])
    @tasks = @band.tasks
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
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to mybands_path
    authorize @band
  end

  private

  def band_params
    params.require(:band).permit(:name, :photo, :user_id)
  end

end
