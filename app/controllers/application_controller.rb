class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :navbar
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end
  def navbar
    if user_signed_in?
      @invites = Invite.where("first_user_id = ? OR second_user_id = ?", current_user.id,  current_user.id).includes(:messages)
      @unanswered_messages = []
      @invites.count do |invite|
        invite.messages.each do |message|
          @unanswered_messages << message if invite.messages.last.user_id != current_user.id
        end
      end
      # raise
      # @invite_messages = @invites.map { |invite| invite.messages }
      # @invite_messages = @invite_messages.delete_if { |e| e.empty? }
      # @unanswered_messages = []
      # @invite_messages.each do |message|
      #   @unanswered_messages << message if message.last.user_id != current_user.id
      # end

    end
  end

  private
  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
