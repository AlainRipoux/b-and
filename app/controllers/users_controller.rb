class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = policy_scope(User)
  end

  def show
    @bands = UserBand.where(user: @user)
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :nickname, :instrument, :biography, :style, :photo, :address)
  end
end
