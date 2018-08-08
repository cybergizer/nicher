require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { described_class.new(name: 'clothes') }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'validates name length' do
      expect(subject).to be_valid
      subject.name = 'Wr'
      expect(subject).to_not be_valid
      subject.name = 'My favourite clothes'
      expect(subject).to_not be_valid
    end
  end
end
