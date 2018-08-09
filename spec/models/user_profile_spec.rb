require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }

  it 'should be a UserProfile' do
    user.user_profile = UserProfile.create(full_name: 'Alex', city: 'Minsk', description: 'test')
    expect(user.user_profile).to be_kind_of(UserProfile)
  end

  it 'is not valid without a city' do
    expect(UserProfile.create(full_name: 'Alex', description: 'test')).to_not be_valid
  end

  it 'is not valid without a full_name' do
    expect(UserProfile.create(city: 'Minsk', description: 'test')).to_not be_valid
  end

  it 'is not valid without a description' do
    expect(UserProfile.create(full_name: 'Alex', city: 'Minsk')).to_not be_valid
  end

  it 'is actual contained in UserProfile table' do
    user.user_profile = UserProfile.create(full_name: 'Alex', city: 'Minsk', description: 'test')
    expect(UserProfile.all).to contain_exactly(user.user_profile)
  end

  it 'is returns actual attributes' do
    user.user_profile = UserProfile.create(full_name: 'Alex', city: 'Minsk', description: 'test')
    expect(user.user_profile.full_name).to eq('Alex')
    expect(user.user_profile.city).to eq('Minsk')
    expect(user.user_profile.description).to eq('test')
  end
end
