class PongsController < ApplicationController
  before_action :authenticate_user!

  def create
    Pong.create(
      user: current_user,
      ping: ping,
      active: true
    )

    redirect_to teams_path
  end

  def update
    pong.update(pong_params)
    pong.ping.update(active: false) if pong.ping.suscribed_pongs.empty?

    redirect_to teams_path
  end

  private

  def pong_params
    params.permit(:active)
  end

  def ping
    @ping ||= Ping.find(params[:ping_id])
  end

  def pong
    @pong ||= Pong.find(params[:id])
  end
end
