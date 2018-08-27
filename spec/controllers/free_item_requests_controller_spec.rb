require 'rails_helper'

RSpec.describe FreeItemRequestsController, type: :controller do
  let(:user_actual) { create(:user) }
  let(:user_potential) { create(:user) }
  let(:item) { create(:item, user: user_actual) }
  let(:request) { create(:free_item_request, item: item, actual_owner: item.user, potential_owner: user_potential) }
  before do
    sign_in user_potential
  end

  describe 'post #new' do
    let(:free_params) { { item_id: item.id, actual_owner_id: item.user.id, potential_owner_id: user_potential.id } }
    subject { post :new,  params: free_params }

    it 'creates a new request' do
      expect { subject }.to change(FreeItemRequest, :count).by(1)
    end
  end

  describe 'post #give_away' do
    let(:item_params) { { item_id: item.id, id: request.id } }
    subject { post :give_away,  params: item_params }

    it 'creates new item to potential_owner' do
      expect { subject }.to change(Item, :count).by(1)
    end

    it 'softly destroys request' do
      expect { subject }.to change(FreeItemRequest, :count).by(0)
    end
  end
end
