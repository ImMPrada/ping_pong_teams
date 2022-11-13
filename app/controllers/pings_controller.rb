class PingsController < ApplicationController
  before_action :authenticate_user!

  def create
    ping = Ping.create(
      user: current_user,
      team: team,
      active: true
    )

    Pong.create(
      user: current_user,
      ping: ping,
      active: true
    )

    redirect_to teams_path
  end

  private

  def team
    @team ||= Team.find(params[:team_id])
  end
end
