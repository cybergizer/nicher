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
#binding.pry
      expect(response).to redirect_to(request.path)
      expect(flash[:alert]).to match(/You are not authorized to access this page: \//)
    end
  end

  describe 'Check access to admin panel for Admin' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'render dashboard page' do
      user.add_role('admin')
      get :dashboard
      expect(response).to render_template "rails_admin/main/dashboard"
    end
  end
end
