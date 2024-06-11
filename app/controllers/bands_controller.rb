class BandsController < ApplicationController
  def index
    @bands = policy_scope(Band)
  end

  def show
    @band = Band.find(params[:id])
    @tasks = @band.tasks
    @band_message = BandMessage.new
    @second_users = current_user.invites_sent.where(status: "accepted").map { |invite| invite.second_user }
    @first_users = current_user.invites.where(status: "accepted").map { |invite| invite.first_user }
    @mates = @second_users + @first_users
    authorize @band
  end

  def new
    @band = Band.new
    @second_users = current_user.invites_sent.where(status: "accepted").map { |invite| invite.second_user }
    @first_users = current_user.invites.where(status: "accepted").map { |invite| invite.first_user }
    @mates = @second_users + @first_users
    authorize @band
  end

  def create
    @band = Band.new(band_params)
    @band.user = current_user
    UserBand.create(band: @band, user: current_user)
    params[:band][:user_id].reject{|u| u == ""}.each {|user_id| UserBand.create(band: @band, user: User.find(user_id.to_i))}
    authorize @band
    if @band.save
      redirect_to mybands_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @band = Band.find(params[:id])
    @second_users = current_user.invites_sent.where(status: "accepted").map { |invite| invite.second_user }
    @first_users = current_user.invites.where(status: "accepted").map { |invite| invite.first_user }
    @mates = @second_users + @first_users
    authorize @band
  end

  def update
    @band = Band.find(params[:id])
    @band.update(band_params)
    params[:band][:user_id].reject{|u| u == ""}.each {|user_id| UserBand.create(band: @band, user: User.find(user_id.to_i))}
    redirect_to band_path(@band)
    authorize @band
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
    params.require(:band).permit(:name, :photo)
  end

end
