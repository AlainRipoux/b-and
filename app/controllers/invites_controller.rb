class InvitesController < ApplicationController
before_action :set_invite, only: %i[update accept decline]
skip_before_action :verify_authenticity_token

  def index
    @invites = policy_scope(Invite)
    @invites = @invites.includes(:first_user, :second_user)
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

    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.text { render partial: "invites/invites_button", locals: {invite: @invite, user: @current_user}, formats: [:html] }
    end
  end

  def accept
    authorize @invite
    @invite.update(status: "accepted")
    @invite.save!
    @invites = @current_user.invites.where.not(status:'declined')
    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.text { render partial: "invites/invites_button", locals: {invites: @invites, user: @current_user}, formats: [:html] }
    end
  end

  def decline
    authorize @invite
    @invite.update(status: "declined")
    @invite.save!
    @invites = @current_user.invites.where.not(status:'declined')
    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.text { render partial: "invites/invites_button", locals: {invites: @invites, user: @current_user}, formats: [:html] }
    end
  end

  private

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def params_invite
    params.require(:invite).permit(:status)
  end
end
