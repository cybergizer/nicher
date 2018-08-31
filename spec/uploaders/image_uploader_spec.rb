require 'carrierwave/test/matchers'
require 'spec_helper'

RSpec.describe ImageUploader, type: :uploader do
  include CarrierWave::Test::Matchers
  let(:item) { build(:item) }
  let(:uploader) { ImageUploader.new(item, attachments: []) }

  describe 'with a test url' do
    before do
      ImageUploader.enable_processing = true
      File.open(File.join(Rails.root,'spec/fixtures/files/avatar.jpg')) { |f| uploader.store!(f) }
    end

    context 'the versions' do
      it 'scales down a landscape image to be exactly 300 by 300 pixels' do
        expect(uploader.page_size).to have_dimensions(600, 400)
      end

      it 'scales down a landscape image to be exactly 250 by 250 pixels' do
        expect(uploader.list_size).to have_dimensions(200, 200)
      end
    end

    after do
      ImageUploader.enable_processing = false
      uploader.remove!
    end
  end
end
