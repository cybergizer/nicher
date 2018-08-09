require 'rails_helper'

RSpec.describe NichesController, type: :controller do
  login_user

  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
  let(:valid_attributes) {
    {
      name: 'dfsdfsdf',
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
      Niche.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      niche = Niche.create! valid_attributes
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
      niche = Niche.create! valid_attributes
      get :edit, params: {id: niche.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new Location" do
      expect {
        post :create, params: {niche: valid_attributes}, session: valid_session
      }.to change(Niche, :count).by(1)
    end

    it "redirects to the created location" do
      post :create, params: {niche: valid_attributes}, session: valid_session
      expect(response).to redirect_to(Niche.last)
    end

    it "returns a success response (i.e. to display the 'new' template)" do
      post :create, params: {niche: invalid_attributes}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      {
        name: 'asafd',
        user_id: user.id
      }
    }

    it "updates the requested location" do
      niche = Niche.create! valid_attributes
      put :update, params: {id: niche.to_param, niche: new_attributes}, session: valid_session
      niche.reload
      expect(response).to redirect_to(niche)
    end

    it "redirects to the location" do
      niche = Niche.create! valid_attributes
      put :update, params: {id: niche.to_param, niche: valid_attributes}, session: valid_session
      expect(response).to redirect_to(niche)
    end

    it "returns a success response (i.e. to display the 'edit' template)" do
      niche = Niche.create! valid_attributes
      put :update, params: {id: niche.to_param, niche: invalid_attributes}, session: valid_session
      expect(response).to_not be_successful
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested location" do
      niche = Niche.create! valid_attributes
      expect {
        delete :destroy, params: {id: niche.to_param}, session: valid_session
      }.to change(Niche, :count).by(-1)
    end

    it "redirects to the locations list" do
      niche = Niche.create! valid_attributes
      delete :destroy, params: {id: niche.to_param}, session: valid_session
      expect(response).to redirect_to(niches_url)
    end
  end
end
