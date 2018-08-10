require 'rails_helper'

RSpec.describe NichesController, type: :controller do
  login_user

  let(:user) { subject.current_user }
  let(:valid_attributes) {
    {
      name: 'Home',
      user_id: user.id
    }
  }

  let(:invalid_attributes) {
    {
      user_id: user.id
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      niche = Niche.create!(valid_attributes)
      get :show, params: {id: niche.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      niche = Niche.create!(valid_attributes)
      get :edit, params: {id: niche.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new Niche" do
      expect {
        post :create, params: {niche: valid_attributes}, session: valid_session
      }.to change(Niche, :count).by(1)
    end

    it "redirects to the created niche" do
      post :create, params: {niche: valid_attributes}, session: valid_session
      niche = assigns(:niche)
      expect(response).to redirect_to(niche)
    end

    it "returns a success response (i.e. to display the 'new' template)" do
      post :create, params: {niche: invalid_attributes}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      {
        name: 'Box',
        user_id: user.id
      }
    }

    let(:not_valid_new_attributes) {
      {
        name: 'Box',
        user_id: 1
      }
    }

    it "updates the requested niche" do
      niche = Niche.create!(valid_attributes)
      put :update, params: {id: niche.to_param, niche: new_attributes}, session: valid_session
      niche.reload
      expect(niche.name).to eq(new_attributes[:name])
      expect(response).to redirect_to(niche)
    end

    it "check that user can not be changed" do
      niche = Niche.create!(valid_attributes)
      put :update, params: {id: niche.to_param, niche: not_valid_new_attributes}, session: valid_session
      niche.reload
      expect(niche.user_id).not_to eq(not_valid_new_attributes[:user_id])
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested niche" do
      niche = Niche.create!(valid_attributes)
      expect {
        delete :destroy, params: {id: niche.to_param}, session: valid_session
      }.to change(Niche, :count).by(-1)
    end

    it "redirects to the niches list" do
      niche = Niche.create!(valid_attributes)
      delete :destroy, params: {id: niche.to_param}, session: valid_session
      expect(response).to redirect_to(niches_url)
    end
  end
end
