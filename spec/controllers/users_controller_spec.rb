require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  login_user
  let(:valid_session) { {} }

  describe 'show action' do
    it 'returns http success' do
      get :show, params: { id: subject.current_user.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'edit action' do
    it 'returns http success' do
      get :edit, params: { id: subject.current_user.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'update action' do
    let(:new_attributes) {
      {
      full_name: 'alex',
      city: 'minsk',
      description: 'test',
      user_id: subject.current_user.id
      }
    }

    it 'updates the requested user profile' do
      put :update, params: { id: subject.current_user.id, user: { user_profile: new_attributes } }, session: valid_session
      expect(response).to redirect_to(subject.current_user)
    end
  end

  describe 'finish sign_up' do
    let(:new_attributes) {
      {
      name: 'alex',
      email: 'test_user@test.com',
      user_id: subject.current_user.id
      }
    }
    it 'updates the requested user' do
      patch :finish_signup, params: { id: subject.current_user.id, user: { user: new_attributes } }, session: valid_session
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe 'destroy action' do
    it 'redirects to root' do
      delete :destroy, params: { id: subject.current_user, user: { password: subject.current_user.password } }
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'show settings form' do
    before do
      get :settings, params: { id: subject.current_user }
    end
    it 'redirects to settings path' do
      expect(response).to render_template :settings
    end
  end
end
