require 'rails_helper'

RSpec.describe RailsAdmin::MainController, type: :controller do
  routes { RailsAdmin::Engine.routes }

  describe 'Check access to admin panel for User' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'redirects to root path' do
      get :dashboard
      expect(response).to redirect_to(request.path)
      expect(flash[:alert]).to match(/You are not authorized to access this page: \//)
    end
  end
end
