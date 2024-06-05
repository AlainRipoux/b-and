class InvitesController < ApplicationController
before_action :set_invite, only: %i[update accept decline]
  def index
    @invites = policy_scope(Invite)
  end

  def create
    @invite = Invite.new
    @invite.first_user = current_user
    @invite.second_user = User.find(params[:user_id])
    @invite.save
    authorize @invite
    redirect_to "/users/show"
  end

  def update
    @invite.update(params_invite)
    authorize @invite
    redirect_to notifications_path
  end

  def accept
    @invite.update(status: "accepted")
    authorize @invite
    redirect_to notifications_path
  end

  def decline
    @invite.update(status: "declined")
    authorize @invite
    redirect_to notifications_path
  end

  private

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def params_invite
    params.require(:invite).permit(:status)
  end
end
