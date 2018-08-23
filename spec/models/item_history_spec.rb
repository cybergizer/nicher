require 'rails_helper'

RSpec.describe ItemHistory, type: :model do
  let(:user) { create(:user) }
  let(:tenant) { create(:contact) }
  let(:item) { create(:item, user: user) }
  let(:rent_item) { create(:rent_item, item: item, owner: user, tenant: tenant) }
  subject { described_class.create(item: item, rent_item_id: rent_item.id) }

  describe 'item_history validation' do
    it 'is not valid without item' do
      subject.item = nil
      expect(subject).to_not be_valid
    end
  end

  describe '#find' do
    it 'finds deleted rent_item' do
      rent_item.destroy
      result = RentItem.only_deleted.find_by_id(subject.rent_item_id)
      expect(result).to eq(subject.find)
    end
  end
end