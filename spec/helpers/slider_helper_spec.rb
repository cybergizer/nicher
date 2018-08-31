require "spec_helper"

describe SliderHelper do
  describe '#slider' do
    let(:user) { create(:user) }
    let(:item) { create(:item_with_image, user: user) }

    it 'returns html' do
      expect(indicators(item.attachments)).to match(/<li class='active' data-slide-to='0' data-target='#myCarousel'>/)
    end

    it 'returns html ' do
      expect(slides(item.attachments)).to match(/<div class='item active'>/)
    end

    it 'returns active if first element' do
      expect(class_active(0)).to eq('active')
    end

    it 'returns active if first element' do
      expect(class_active(2)).to eq('')
    end
  end
end
