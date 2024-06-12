class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = policy_scope(User)

    if params[:instrument].present?
      selected_instrument = params[:instrument].reject(&:blank?)
      @users = @users.where(instrument: selected_instrument)
    end

    if params[:style].present?
      selected_style = params[:style].reject(&:blank?)
      @users = @users.where(style: selected_style)
    end

    if params[:availability].present?
      selected_availability = params[:availability].reject(&:blank?)
      @users = @users.where(availability: selected_availability)
    end

    if params[:frequency].present?
      selected_frequency = params[:frequency].reject(&:blank?)
      @users = @users.where(frequency: selected_frequency)
    end

    if params[:objectives].present?
      selected_objectives = params[:objectives].reject(&:blank?)
      @users = @users.where(objectives: selected_objectives)
    end

    if params[:projects].present?
      selected_projects = params[:projects].reject(&:blank?)
      @users = @users.where(projects: selected_projects)
    end

    if params[:location].present?
      @close_users = User.near(current_user.address, params[:location].to_i)
      @users = @users.where(id: @close_users.map(&:id))
    end

    # @users = @users.includes(photo_attachment: :blob)

  end

  def show
    @bands = UserBand.where(user: @user)
    @usermates = Invite.where("first_user_id = ? OR second_user_id = ?", @user.id,  @user.id)
    @mymates = Invite.where("first_user_id = ? OR second_user_id = ?", @current_user.id,  @current_user.id)
    @first_user = @mymates.map {|mate| mate.first_user }.include?(@user)
    @second_user = @mymates.map {|mate| mate.second_user }.include?(@user)
    @invite = @mymates.where("first_user_id = ? OR second_user_id = ?", @user.id,  @user.id)
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
    params.require(:user).permit(:firstname, :lastname, :nickname, :instrument, :biography, :style, :photo, :address, :availability, :frequency, :objectives, :projects)

  end
end
