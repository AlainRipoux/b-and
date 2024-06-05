class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = policy_scope(User)

    if params[:instrument].present?
      selected_instrument = params[:instrument].reject(&:blank?)
      @users = policy_scope(User).where(selected_instrument.map { |instrument| "instrument LIKE ?" }.join(' AND '), *selected_instrument.map { |instrument| "%#{instrument}%" })
    end

    if params[:style].present?
      selected_style = params[:style].reject(&:blank?)
      @users = policy_scope(User).where(selected_style.map { |style| "style LIKE ?" }.join(' AND '), *selected_style.map { |style| "%#{style}%" })
    end

    if params[:availability].present?
      selected_availability = params[:availability].reject(&:blank?)
      @users = policy_scope(User).where(selected_availability.map { |availability| "availability LIKE ?" }.join(' AND '), *selected_availability.map { |availability| "%#{availability}%" })
    end

    if params[:frequency].present?
      selected_frequency = params[:frequency].reject(&:blank?)
      @users = policy_scope(User).where(selected_frequency.map { |frequency| "frequency LIKE ?" }.join(' AND '), *selected_frequency.map { |frequency| "%#{frequency}%" })
    end

    if params[:objectives].present?
      selected_objectives = params[:objectives].reject(&:blank?)
      @users = policy_scope(User).where(selected_objectives.map { |objectives| "objectives LIKE ?" }.join(' AND '), *selected_objectives.map { |objectives| "%#{objectives}%" })
    end

    if params[:projects].present?
      selected_projects = params[:projects].reject(&:blank?)
      @users = policy_scope(User).where(selected_projects.map { |projects| "projects LIKE ?" }.join(' AND '), *selected_projects.map { |projects| "%#{projects}%" })
    end
  end

  def show
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
