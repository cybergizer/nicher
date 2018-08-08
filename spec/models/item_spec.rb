require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password') }
  subject { described_class.new(title: 'Watch', description: 'Apple watch', user_id: user.id) }

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
end
