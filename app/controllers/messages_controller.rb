class MessagesController < ApplicationController
  def index
    @messages = policy_scope(Message)
    @invites = Invite.where(user: current_user)
  end

  def create
    @invite = Invite.find(params[:invite_id])
    @message = Message.new(message_params)
    @message.invite = @invite
    @message.user = current_user
    authorize @message
    if @message.save
      redirect_to invite_messages(@invite)
    else
      render "invites/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
