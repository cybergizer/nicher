require 'rails_helper'

RSpec.describe NichesController, type: :controller do
  login_user

  let(:user) { subject.current_user }
  let(:niche) { create(:niche, user: user) }
  let(:parent_niche) { create(:new_niche, user: user) }
  let(:valid_attributes) { attributes_for(:niche).merge(user_id: user.id) }
  let(:invalid_attributes) { attributes_for(:invalid_niche) }

  describe 'GET #index' do

    before do
      get :index
    end

    it 'renders the :index view' do
      expect(response).to render_template :index
    end

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: niche }
    end

    it 'assigns the requested niche to @niche' do
      expect(assigns(:niche)).to eq(niche)
    end

    it "renders the #show view" do
      expect(response).to render_template :show
    end

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'assigns the niche' do
      expect(assigns(:niche)).to be_a_new(Niche)
    end

    it "renders the new view page" do
      expect(response).to render_template(partial: 'niches/_form')
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: niche }
    end

    it 'assigns the niche' do
      expect(assigns(:niche)).to eq(niche)
    end

    it "renders the edit view page" do
      expect(response).to render_template(partial: 'niches/_form')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Niche' do
        expect {
          post :create, params: { niche: valid_attributes }
        }.to change(Niche, :count).by(1)
      end

      it 'redirects to the created niche' do
        post :create, params: { niche: valid_attributes }
        niche = assigns(:niche)
        expect(response_to_json).to eq({ 'status' => 'ok' })
      end
    end

    context 'with invalid params' do
      context 'when empty name' do
        it "does not save the new niche" do
          expect{
            post :create, params: { niche: invalid_attributes }
          }.to_not change(Niche, :count)
        end

        it "re-renders the new method" do
          post :create, params: { niche: invalid_attributes }
          niche = assigns(:niche)
          expect(niche.errors.messages[:name]).to be_present
          expect(response_to_json).to eq({ 'status' => 'error' })
        end
      end

      context 'when invalid url' do
        let(:invalid_attributes) { { name: 'Garage', url: 'invalid/url' } }

        it "does not save the new niche" do
          expect{
            post :create, params: { niche: invalid_attributes }
          }.to_not change(Niche, :count)
        end

        it "re-renders the new method" do
          post :create, params: { niche: invalid_attributes }
          niche = assigns(:niche)
          expect(niche.errors.messages[:url]).to be_present
          expect(response_to_json).to eq({ 'status' => 'error' })
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        put :update, params: { id: niche, niche: new_attributes }
      end

      let(:new_attributes) { attributes_for(:new_niche).merge(user_id: user.id) }

      it 'updates the requested niche' do
        expect(assigns(:niche)).to eq(niche)
      end

      it "changes niche's attributes" do
        niche.reload
        expect(niche.name).to eq('Garage')
      end
    end

    context 'with invalid params' do
      context 'when empty name' do
        before do
          put :update, params: { id: niche, niche: invalid_attributes }
        end

        it "does not change niche's attributes" do
          niche.reload
          expect(niche.name).to_not be_nil
        end

        it "re-renders the edit method " do
          niche = assigns(:niche)
          expect(niche.errors.messages[:name]).to be_present
          expect(response_to_json).to eq({ 'status' => 'error' })
        end
      end

      context 'when invalid url' do
        let(:invalid_attributes) { { name: 'Garage', url: 'invalid/url' } }

        before do
          put :update, params: { id: niche, niche: invalid_attributes }
        end

        it "does not change niche's attributes" do
          niche.reload
          expect(niche.url).to_not eq('invalid/url')
        end

        it "re-renders the edit method " do
          niche = assigns(:niche)
          expect(niche.errors.messages[:url]).to be_present
          expect(response_to_json).to eq({ 'status' => 'error' })
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested niche' do
      niche = create(:niche, user: user)
      expect {
        delete :destroy, params: { id: niche }
      }.to change(Niche, :count).by(-1)
    end

    it 'redirects to the niches list' do
      delete :destroy, params: { id: niche }
      expect(response).to redirect_to(niches_url)
    end
  end

  describe 'POST #move' do
    before do
      post :move, params: { id: niche.id, parent_id: parent_niche.id }
    end

    it 'change parent for niche' do
      niche.reload
      expect(niche.parent).to eq(parent_niche)
    end
  end

  describe 'Get #highlight' do
    let(:niche) { create(:niche, user: user, url: 'https://www.google.com/') }

    it 'return http success' do
      get :highlight, params: { id: niche.id }
      expect(response_to_json).to eq('status' => 'ok')
      expect(response).to have_http_status(:success)
    end
  end
end
