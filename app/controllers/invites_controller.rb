class InvitesController < ApplicationController

  def create
    @invite = Invite.new
    @invite.first_user = current_user
    @invite.second_user = User.find(params[:user_id])
    @invite.save
    redirect_to "/users/show"
  end
end
