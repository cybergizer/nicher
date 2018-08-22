require 'rails_helper'

RSpec.describe SharedItem, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  subject { create(:shared_item, item: item) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without item" do
    subject.item = nil
    expect(subject).to_not be_valid
  end
end
