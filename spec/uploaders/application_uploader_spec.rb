require 'carrierwave/test/matchers'
require 'spec_helper'

RSpec.describe ApplicationUploader, type: :uploader do
  include CarrierWave::Test::Matchers
  let(:user_profile) { build(:user_profile) }
  let(:uploader) { ApplicationUploader.new(user_profile, :avatar) }

  describe 'with a test url' do
    before do
      ApplicationUploader.enable_processing = true
      File.open(File.join(Rails.root,'spec/fixtures/files/avatar.jpg')) { |f| uploader.store!(f) }
    end

    it 'has the correct format' do
      expect(uploader).to be_format('JPEG')
    end

    it 'has the correct size' do
      expect(uploader.size).to be <= 1.megabyte
    end

    after do
      ApplicationUploader.enable_processing = false
      uploader.remove!
    end
  end
end
