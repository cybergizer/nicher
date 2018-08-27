require 'rails_helper'

RSpec.describe FreeItemRequest, type: :model do
  let(:user) { create(:user) }
  let(:potential_user) { create(:user) }
  let(:item) { create(:item, user: user) }
  subject { create(:free_item_request, actual_owner: user, potential_owner: potential_user, item: item) }

  it "is not valid without item" do
    subject.item = nil
    expect(subject).to_not be_valid
  end
end
