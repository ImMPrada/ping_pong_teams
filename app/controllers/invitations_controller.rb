class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    return respond_with_errors('User does not exist.') if recipient.blank?

    invitation_sender = InvitationSender.new(current_user, recipient, team)
    return respond_with_errors(invitation_sender.error_messages.join(', ')) unless invitation_sender.valid?

    invitation = invitation_sender.create
    ActionCable.server.broadcast(
      "invitation_channel_user_#{invitation.recipient_id}",
      { invitation: render_invitation(invitation) }
    )
  end

  def index
    @invitations = current_user.received_invitations.where(active: true)
  end

  def update
    invitation.update(
      accepted: params[:accepted],
      active: false
    )

    if invitation.accepted
      TeamUser.create(
        user: current_user,
        team: invitation.team,
        role: TeamUser::ROLES[:member]
      )
    end

    flash[:success] = 'Invitations updated'
    redirect_to invitations_path
  end

  private

  def invitation
    @invitation ||= Invitation.find(params[:id])
  end

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

  def render_invitation(invitation)
    render(partial: 'invitation', locals: { invitation: invitation })
  end
end
