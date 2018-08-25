require 'rails_helper'

RSpec.describe FreeItemRequestsController, type: :controller do
  let(:user_actual) { create(:user) }
  let(:user_potential) { create(:user) }
  let(:item) { create(:item, user: user_actual) }
  before do
    sign_in user_potential
  end

  describe "#new" do
    it 'creates new item' do
      expect(assigns(:request)).to be_a_new(FreeItemRequest)
    end
  end
end
