require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  subject { described_class.create(title: 'Watch', description: 'Apple watch', user: user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
      subject.description = nil
      expect(subject).to be_valid
    end

    it 'is not valid without an user' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end

  describe '#search' do
    it 'finds the item' do
      item = subject
      result = Item.search('Watch').first
      expect(result).to eq(item)
    end

    it 'assets all items if parameter not passed' do
      item = subject
      result = Item.search(nil)
      expect(result).to eq(Item.all)
    end

    describe '#display_created_at' do
      it 'displays time' do
        item = subject
        result = item.display_created_at
        expect(result).to eq (item.created_at.strftime "%B %e, %Y")
      end
    end
  end
end
