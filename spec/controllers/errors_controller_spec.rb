require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #not_found' do
    before do
      get :not_found
    end

    it 'returns http 404' do
      expect(response).to have_http_status('404')
    end

    it 'renders the not_found view' do
      expect(response).to render_template :not_found
    end
  end

  describe 'GET #internal_server_error' do
    before do
      get :internal_server_error
    end

    it 'returns http 500' do
      expect(response).to have_http_status('500')
    end

    it 'renders the internal_server_error view' do
      expect(response).to render_template :internal_server_error
    end
  end
end
