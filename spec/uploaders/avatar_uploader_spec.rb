require 'carrierwave/test/matchers'

RSpec.describe AvatarUploader, type: :uploader do
  include CarrierWave::Test::Matchers
  let(:user_profile) { FactoryBot.build(:user_profile) }
  let(:uploader) { AvatarUploader.new(user_profile, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open(File.join(Rails.root,'spec/fixtures/files/avatar.jpg')) { |f| uploader.store!(f) }
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

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end
end
