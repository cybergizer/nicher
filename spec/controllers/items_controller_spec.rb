require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  login_user

  let(:user) { subject.current_user }
  let(:item) { create(:item, user: user) }
  let(:valid_attributes) { attributes_for(:item).merge(user_id: user.id) }
  let(:invalid_attributes) { attributes_for(:invalid_item) }

  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the :index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    context 'with valid params' do
      before do
        get :show, params: { id: item }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns the requested item to @item' do
        expect(assigns(:item)).to eq(item)
      end

      it "renders the #show view" do
        expect(response).to render_template :show
      end
    end

    context 'with invalid params' do
      before do
        get :show, params: { id: 0 }
      end

      it 'returns http success' do
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: item }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the item' do
      expect(assigns(:item)).to eq(item)
    end

    it "renders the #edit view" do
      expect(response).to render_template :edit
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'assigns the item' do
      expect(assigns(:item)).to be_a_new(Item)
    end

    it "renders the new view page" do
      expect(response).to render_template :new
    end

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Item' do
        expect {
          post :create, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it 'redirects to the created item' do
        post :create, params: { item: valid_attributes }
        item = assigns(:item)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(item)
        expect(flash[:notice]).to match(/Item was successfully created\./)
      end
    end

    context 'with invalid params' do
      it "does not save the new item" do
        expect{
          post :create, params: { item: invalid_attributes }
        }.to_not change(Item,:count)
      end

      it "re-renders the new method" do
        post :create, params: { item: invalid_attributes }
        item = assigns(:item)
        expect(item.errors.messages[:title]).to include "can't be blank"
        expect(response).to render_template :new
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        put :update, params: { id: item, item: new_attributes }
      end

      let(:new_attributes) { attributes_for(:new_item) }

      it 'updates the requested item' do
        expect(assigns(:item)).to eq(item)
      end

      it "changes item's attributes" do
        item.reload
        expect(item.description).to eq("It's socks")
      end

      it 'redirects to the item' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(item)
        expect(flash[:notice]).to match(/Item was successfully updated\./)
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: item, item: invalid_attributes }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it "does not change item's attributes" do
        item.reload
        expect(item.title).to_not be_nil
      end

      it "re-renders the edit method " do
        item = assigns(:item)
        expect(item.errors.messages[:title]).to include "can't be blank"
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested item' do
      item = create(:item, user: user)
      expect {
        delete :destroy, params: { id: item }
      }.to change(Item, :count).by(-1)
    end

    it 'redirects to the items list' do
      delete :destroy, params: { id: item }
      expect(response).to redirect_to(items_url)
      expect(flash[:notice]).to match(/Item was successfully destroyed\./)
    end
  end
end
