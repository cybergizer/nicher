require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe UserProfile, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user_profile) { FactoryBot.build(:user_profile) }
  let(:user_profile_without_a_full_name) { FactoryBot.build(:user_profile_without_a_full_name) }

  it 'should be a UserProfile' do
    user.user_profile = user_profile
    expect(user.user_profile).to be_kind_of(UserProfile)
  end

  it 'is not valid without a full_name' do
    expect(user_profile_without_a_full_name).to_not be_valid
  end

  it "when we create user model, it hasn't an user profile" do
    expect(user.user_profile).to be_nil
  end

  it 'is actual contained in UserProfile table' do
    user.user_profile = user_profile
    expect(UserProfile.all).to contain_exactly(user.user_profile)
  end

  it 'is returns actual attributes' do
    user.user_profile = user_profile
    expect(user.user_profile.full_name).to eq('Alex')
    expect(user.user_profile.city).to eq('Minsk')
    expect(user.user_profile.description).to eq('test')
  end
end

RSpec.describe AvatarUploader, type: :uploader do
  include CarrierWave::Test::Matchers
  let(:user_profile) { FactoryBot.build(:user_profile) }
  let(:uploader) { AvatarUploader.new(user_profile, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open(File.join(Rails.root,'spec/fixtures/files/avatar.jpg')) { |f| uploader.store!(f) }
  end

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end

  context 'the versions' do
    it 'scales down a landscape image to be exactly 250 by 250 pixels' do
      expect(uploader.thumb).to have_dimensions(250, 250)
    end

    it 'scales down a landscape image to be exactly 250 by 250 pixels' do
      expect(uploader.icon).to have_dimensions(50, 50)
    end
  end

  it 'has the correct format' do
    expect(uploader).to be_format('JPEG')
  end

  it 'has the correct size' do
    expect(uploader.size).to be <=1000000 # bytes
  end
end
