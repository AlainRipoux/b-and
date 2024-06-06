class MessagesController < ApplicationController
  def index
    @messages = policy_scope(Message)
    @invites = Invite.where("first_user_id = ? OR second_user_id = ?", current_user.id,  current_user.id)
    @invite_messages = @invites.map {|invite| invite.messages}
    @invite_messages = @invite_messages.delete_if {|e| e.empty? }
  end

  def show
    @invite = Invite.find(params[:invite_id])
    @message = Message.new
    authorize @message
  end

  def create
    @invite = Invite.find(params[:invite_id])
    @message = Message.new(message_params)
    @message.invite = @invite
    @message.user = current_user
    authorize @message
    if @message.save
      redirect_to invite_messages_path(@invite)
    else
      render "messages/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
