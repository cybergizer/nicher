require 'rails_helper'

RSpec.describe SharedItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:user_2) { create(:user, email: 'test2@mail.ru') }
  let(:item) { create(:item, user: user) }

  before do
    sign_in user
  end

  describe 'GET #shared_form' do
    let(:item_params) { { id: item.id } }
    subject { get :generate_link, params: item_params }

    context 'with valid params' do
      it 'renders the share_form' do
        expect(subject).to render_template "items/popups/_share_form"
      end

      it 'creates a new SharedItem' do
        expect { subject }.to change(SharedItem, :count).by(1)
      end

      it "returns http success" do
        expect(subject).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      let(:item_params) { { } }

      it "doesn't create a SharedItem" do
        expect { subject }.to_not change(SharedItem, :count)
      end

      it "redirects to the items" do
        expect(subject).to have_http_status(:redirect)
        expect(flash[:notice]).to match(/You don't have this item\./)
      end
    end
  end

  describe 'get #share' do
    let(:item) { create(:item, user: user_2) }
    let(:shared_item) { create(:shared_item, item: item) }
    subject { get :share, params: token }

    context 'with valid params' do
      let(:token) { { token: shared_item.token } }

      it 'creates a new RentItem' do
        expect { subject }.to change(RentItem, :count).by(1)
      end

      it 'destroy a SharedItem' do
        shared_item.save
        expect { subject }.to change(SharedItem, :count).by(-1)
      end

      it 'redirects to the items' do
        expect(subject).to have_http_status(:redirect)
        expect(subject).to redirect_to(items_path)
        expect(flash[:notice]).to match(/You've rent #{item.title} from #{item.user.full_name}\./)
      end
    end

    context 'with invalid params' do
      context 'when owner and tenant are the same' do
        let(:item) { create(:item, user: user) }
        let(:shared_item) { create(:shared_item, item: item) }
        let(:token) { { token: shared_item.token } }

        it "does not save the new RentItem" do
          expect{ subject }.to_not change(RentItem, :count)
        end

        it 'redirects to the items' do
          expect(subject).to have_http_status(:redirect)
          expect(subject).to redirect_to(items_path)
          expect(flash[:notice]).to match(/Invalid Link\./)
        end
      end

      context 'when the link is expired' do
        let(:expired_shared_item) { create(:shared_item, item: item, expiration: Time.zone.now - 1.minute) }
        let(:token) { { token: expired_shared_item.token } }

        before do
          SharedItem.skip_callback(:create, :before, :set_expiration_date)
        end

        after do
          SharedItem.set_callback(:create, :before, :set_expiration_date)
        end

        it "does not save the new RentItem" do
          expect{ subject }.to_not change(RentItem, :count)
        end

        it 'redirects to the items' do
          expect(subject).to have_http_status(:redirect)
          expect(subject).to redirect_to(items_path)
          expect(flash[:notice]).to match(/Invalid Link\./)
        end
      end
    end
  end
end
