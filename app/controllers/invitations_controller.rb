class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    return respond_with_errors('User does not exist.') if recipient.blank?

    invitation_sender = InvitationSender.new(current_user, recipient, team)
    return respond_with_errors(invitation_sender.error_messages.join(', ')) unless invitation_sender.valid?

    invitation_sender.create
    respond_with_success
  end

  private

  def team
    @team ||= Team.find(params[:team_id])
  end

  def recipient
    @recipient ||= User.find_by(username: params[:username])
  end

  def respond_with_success
    flash[:success] = 'Invitation sent'
    redirect_to teams_path
  end

  def respond_with_errors(message)
    flash[:error] = message
    redirect_to new_team_invitation_path
  end
end
