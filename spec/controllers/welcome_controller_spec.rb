require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:user) { create(:user) }
  before do
    sign_in user
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the :index view' do
    	get :index
      expect(response).to render_template :index
    end
  end
end
