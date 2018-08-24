require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user_profile) { FactoryBot.build(:user_profile) }
  let(:user_profile_without_a_first_name) { FactoryBot.build(:user_profile_without_a_first_name) }

  it 'should be a UserProfile' do
    user.user_profile = user_profile
    expect(user.user_profile).to be_kind_of(UserProfile)
  end

  it 'is not valid without a first_name' do
    expect(user_profile_without_a_first_name).to_not be_valid
  end

  it 'is actual contained in UserProfile table' do
    user.user_profile = user_profile
    expect(UserProfile.all).to contain_exactly(user.user_profile)
  end

  it 'is returns actual attributes' do
    user.user_profile = user_profile
    expect(user.user_profile.first_name).to eq('Alex')
    expect(user.user_profile.city).to eq('Minsk')
    expect(user.user_profile.description).to eq('test')
  end
end
