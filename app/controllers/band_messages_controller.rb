class BandMessagesController < ApplicationController
  def create
    @band = Band.find(params[:band_id])
    @band_message = BandMessage.new(band_message_params)
    @band_message.band = @band
    @band_message.user = current_user
    authorize @band_message
    if @band_message.save
      redirect_to band_path(@band)
    else
      render "bands/show", status: :unprocessable_entity
    end
  end

  private

  def band_message_params
    params.require(:band_message).permit(:content)
  end
end
