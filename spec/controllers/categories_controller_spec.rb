require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  login_user

  let(:category) { create(:category, user: subject.current_user) }
  let(:parent_category) { create(:category, user: subject.current_user) }
  let(:valid_attributes) { attributes_for(:category) }
  let(:invalid_attributes) { attributes_for(:invalid_category) }

  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "populates an array of categories" do
      expect(assigns(:categories)).to include category
    end

    it 'renders the :index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: category }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested category to @category' do
      expect(assigns(:category)).to eq(category)
    end

    it "renders the #show view" do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the category' do
      expect(assigns(:category)).to be_a_new(Category)
    end

    it "renders the #new view" do
      expect(response).to render_template(partial: 'categories/_form')
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: category }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the category' do
      expect(assigns(:category)).to eq(category)
    end

    it "renders the #edit view" do
      expect(response).to render_template(partial: 'categories/_form')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Category' do
        expect {
          post :create, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post :create, params: { category: valid_attributes }
        category = assigns(:category)
        expect(response_to_json).to eq({ 'status' => 'ok' })
      end
    end

    context 'with invalid params' do
      it "invalid_attributes return http success" do
        post :create, params: { category: invalid_attributes  }
        expect(response).to have_http_status(:success)
      end

      it "does not save the new category" do
        expect{
          post :create, params: { category: invalid_attributes }
        }.to_not change(Category,:count)
      end

      it "re-renders the new method" do
        post :create, params: { category: invalid_attributes }
        category = assigns(:category)
        expect(response_to_json).to eq({ 'status' => 'error' })
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        put :update, params: { id: category, category: new_attributes }
      end

      let(:new_attributes) { attributes_for(:new_category) }

      it 'updates the requested category' do
        expect(assigns(:category)).to eq(category)
      end

      it "changes category's attributes" do
        category.reload
        expect(category.name).to eq("Toys")
      end

      it 'redirects to the category' do
        expect(response_to_json).to eq({ 'status' => 'ok' })
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: category, category: invalid_attributes }
      end

      it "does not change category's attributes" do
        category.reload
        expect(response_to_json).to_not be_nil
      end

      it "re-renders the edit method " do
        expect(response_to_json).to eq({ 'status' => 'error' })
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      category = create(:category, user: subject.current_user)
      expect {
        delete :destroy, params: { id: category }
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      delete :destroy, params: { id: category }
      expect(response).to redirect_to(categories_url)
      expect(flash[:notice]).to match(/Category was successfully destroyed\./)
    end
  end

  describe 'POST #move' do
    before do
      post :move, params: { id: category.id, parent_id: parent_category.id }
    end

    it 'change parent for category' do
      category.reload
      expect(category.parent).to eq(parent_category)
    end
  end
end
