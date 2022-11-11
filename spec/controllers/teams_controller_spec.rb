require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe '#new' do
    before do
      get :new
    end

    it 'renders the #new template' do
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    before do
      post :create, params: params
    end

    context 'with valid params' do
      let(:params) do
        {
          name: Faker::Game.title,
          logo: Rack::Test::UploadedFile.new('spec/fixtures/images/team_logo.png', 'image/png')
        }
      end

      it 'creates a new team' do
        expect(user.teams.count).to eq(1)
      end

      it 'sets the team name' do
        expect(user.teams.first.name).to eq(params[:name])
      end

      it 'sets the team logo' do
        expect(user.teams.first.logo).to be_attached
      end

      it 'returns a redirect status' do
        expect(response.status).to eq(302)
      end

      it 'redirects back to the teams page' do
        expect(response.redirect_url).to eq(teams_url)
      end
    end

    context 'with invalid params' do
      let(:params) do
        { name: nil }
      end

      it 'returns a redirect status' do
        expect(response.status).to eq(302)
      end

      it 'redirects back to the homepage' do
        expect(response.redirect_url).to eq(new_team_url)
      end
    end
  end

  describe '#index' do
    it 'renders the #index template' do
      get :index
      expect(response).to render_template('index')
    end

    xit "calls current_user's teams" do
    end
  end
end
