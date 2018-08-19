require 'rails_helper'

RSpec.describe SharedItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_2) { create(:user, email: 'test2@mail.ru') }
  let(:item) { create(:item, user: user) }

  before do
    sign_in user
  end

  describe 'GET #shared_form' do
    subject { get :generate_link,  params: { id: item.id } }

    it 'renders the :index view' do
      expect(subject).to render_template "items/popups/_share_form"
    end

    it 'creates a new SharedItem' do
      expect { subject }.to change(SharedItem, :count).by(1)
    end

    it "returns a 200 status code" do
      expect(subject).to have_http_status(:success)
    end
  end

  describe 'get #rent_item' do
    let(:user_profile) { create(:user_profile, user: user_2) }
    let(:item) { create(:item, user: user_2) }
    let(:shared_item) { create(:shared_item, item: item) }
    subject { get :rent_item, params: token }

    before do
      user_profile.save
      shared_item.save
    end

    context 'with valid params' do
      let(:token) { { token: shared_item.token } }

      it 'creates a new RentItem' do
        expect { subject }.to change(RentItem, :count).by(1)
      end

      it 'destroy a SharedItem' do
        expect { subject }.to change(SharedItem, :count).by(-1)
      end

      it 'redirects to the items' do
        expect(subject).to have_http_status(:redirect)
        expect(subject).to redirect_to(items_path)
        expect(flash[:notice]).to match(/You've rent #{item.title} from #{item.user.full_name}\./)
      end
    end

    context 'with invalid params' do
      let(:item) { create(:item, user: user) }
      let(:shared_item) { create(:shared_item, item: item) }
      let(:token) { { token: shared_item.token } }

      it "does not save the new RentItem" do
        expect{ subject }.to_not change(RentItem,:count)
      end

      it 'redirects to the items' do
        expect(subject).to have_http_status(:redirect)
        expect(subject).to redirect_to(items_path)
        expect(flash[:notice]).to match(/Invalid Link\./)
      end
    end
  end
end
