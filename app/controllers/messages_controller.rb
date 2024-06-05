class MessagesController < ApplicationController
  def create
    @invite = Invite.find(params[:invite_id])
    @message = Message.new(message_params)
    @message.band = @band
    @message.user = current_user
    authorize @message
    if @message.save
      redirect_to band_path(@band)
    else
      render "bands/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
