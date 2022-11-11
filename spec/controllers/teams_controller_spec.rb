require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:user) { create(:user) }

  describe '#new' do
    before do
      sign_in user
      get :new
    end

    it 'renders the #new template' do
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    before do
      sign_in user
      post :create, params: params
    end

    context 'with valid params' do
      let(:params) do
        { name: Faker::Game.title }
      end

      it 'creates a new team' do
        expect(user.teams.count).to eq(1)
      end

      it 'sets the team name' do
        expect(user.teams.first.name).to eq(params[:name])
      end

      it 'returns a redirect status' do
        expect(response.status).to eq(302)
      end

      it 'redirects back to the homepage' do
        expect(response.redirect_url).to eq(root_url)
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
end
