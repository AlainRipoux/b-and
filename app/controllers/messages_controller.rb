class MessagesController < ApplicationController
  def index
    @messages = policy_scope(Message)
    # @messages = @messages.includes(:user)
    @invites = Invite.where("first_user_id = ? OR second_user_id = ?", current_user.id, current_user.id).includes(messages: [:user], first_user: [photo_attachment: :blob], second_user: [photo_attachment: :blob])
    @invites = @invites.sort_by { |invite| invite.messages.last.created_at }.reverse
    # @invite_messages = @messages.map {|message| message}.group_by(:invite_id)
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
