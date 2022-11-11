class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    team = current_user.teams.create(team_params)
    return respond_with_errors(team) unless team.valid?

    team.logo.attach(params[:logo])
    current_user.become_owner_of!(team)
    respond_with_success(team)
  end

  def index
    @teams = current_user.teams
  end

  private

  def team_params
    params.permit(:name)
  end

  def respond_with_success(_team)
    flash[:success] = 'Team created!'
    redirect_to teams_path
  end

  def respond_with_errors(team)
    flash[:error] = team.errors.full_messages.to_sentence
    redirect_to new_team_path
  end
end
