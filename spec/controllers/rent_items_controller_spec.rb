require 'rails_helper'

RSpec.describe RentItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  let(:contact) { create(:contact) }
  let(:contact_attributes) { attributes_for(:contact) }
  let(:invalid_contact_attributes) { attributes_for(:invalid_contact) }
  let!(:rent_item) { create(:rent_item, owner: user, tenant: contact, item: item) }

  before do
    sign_in user
  end

  describe 'GET #rent_form' do
    before do
      get :rent_form,  params: { id: item.id }
    end

    it 'renders the :index view' do
      expect(response).to render_template "items/popups/_rent_form"
    end

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #rent' do
    let(:rent_params) { { id: item.id , rent_item: { tenant_attributes: contact_attributes } } }
    subject { post :rent,  params: rent_params }
    
    context 'with valid params' do
      it 'creates a new RentItem' do
        expect { subject }.to change(RentItem, :count).by(1)
      end

      it 'creates a new Contact' do
        expect { subject }.to change(Contact, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:rent_params) { { id: item.id , rent_item: { tenant_attributes: invalid_contact_attributes } } }

      it "does not save the new RentItem" do
        expect{ subject }.to_not change(RentItem,:count)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :repay, params: { id: rent_item.id } }

    it 'destroys the requested rent_item' do
      expect { subject }.to change(RentItem, :count).by(-1)
    end

    it 'redirects to the items list' do
      subject
      expect(response).to redirect_to(items_url)
    end
  end
end
