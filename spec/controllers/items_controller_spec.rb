require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  login_user

  let(:user) { subject.current_user }
  let(:item) { create(:item, user: user) }
  let(:valid_attributes) { attributes_for(:item).merge(user_id: user.id) }
  let(:invalid_attributes) { attributes_for(:invalid_item) }

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
        expect(response).to redirect_to(item)
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
        expect(item.errors).to be_present
        expect(response).to render_template :new
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end
    end
  end
end