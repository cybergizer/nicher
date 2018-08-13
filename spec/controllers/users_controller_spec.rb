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
      put :update, params: { id: subject.current_user.id, user: { user_profile: new_attributes }}, session: valid_session
      expect(response).to redirect_to(subject.current_user)
    end
  end

end
