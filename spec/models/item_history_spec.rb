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

  describe '#rent_item' do
    it 'finds deleted rent_item' do
      rent_item.destroy
      result = RentItem.only_deleted.find_by_id(subject.rent_item_id)
      expect(result).to eq(subject.rent_item)
    end
  end

  describe '#returned_at' do
    it 'finds deleted rent_item' do
      rent_item.destroy
      result = subject.returned_at
      expect(result).to eq(subject.rent_item.deleted_at.strftime '%e %b. %Y')
    end
  end

  describe '#borrowed_at' do
    it 'finds deleted rent_item' do
      rent_item.destroy
      result = subject.borrowed_at
      expect(result).to eq(subject.rent_item.created_at.strftime '%e %b. %Y')
    end
  end
end
