class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    @user.update(params_user) if @user == current_user
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def params_user
    params.require(:user).permit(:firstname, :lastname, :nickname, :instrument, :biography, :style, :photo, :address)
  end
end
