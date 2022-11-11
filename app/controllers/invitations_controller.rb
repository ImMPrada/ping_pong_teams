class InvitationsController < ApplicationController
  def new; end

  def create
    invitation = Invitation.new

    team = Team.find(invitation_params[:team_id])
    recipient = User.find_by(username: invitation_params[:username])

    # TODO: if recipint is nil then return an error
    # TODO: if recipient is already a member of the team then return an error
    # TODO: if recipient has already been invited to the team then return an error
    # TODO: if recipient is the current user then return an error

    invitation.sender = current_user
    invitation.recipient = recipient
    invitation.team = team
    invitation.active = true

    invitation.save
  end

  private

  def invitation_params
    params.permit(:username, :team_id)
  end
end
