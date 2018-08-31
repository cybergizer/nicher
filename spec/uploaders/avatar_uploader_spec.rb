require 'carrierwave/test/matchers'
require 'spec_helper'

RSpec.describe AvatarUploader, type: :uploader do
  include CarrierWave::Test::Matchers
  let(:user_profile) { build(:user_profile) }
  let(:uploader) { AvatarUploader.new(user_profile, :avatar) }

  describe 'with a test url' do
    before do
      AvatarUploader.enable_processing = true
      File.open(File.join(Rails.root,'spec/fixtures/files/avatar.jpg')) { |f| uploader.store!(f) }
    end

    context 'the versions' do
      it 'scales down a landscape image to be exactly 250 by 250 pixels' do
        expect(uploader.thumb).to have_dimensions(250, 250)
      end

      it 'scales down a landscape image to be exactly 50 by 50 pixels' do
        expect(uploader.small).to have_dimensions(50, 50)
      end
    end

    after do
      AvatarUploader.enable_processing = false
      uploader.remove!
    end
  end
end
