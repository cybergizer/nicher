module SliderHelper
  def indicators(images)
    (0..images.count - 1).inject('') do |result, counter|
      result << "<li class='#{class_active(counter)}' data-slide-to='#{counter}' data-target='#myCarousel'></li>"
    end
  end

  def slides(images)
    images.each_with_index.inject('') do |result, (image, index)|
      result << "<div class='item #{class_active(index)}'><img src='#{image.page_size.url}'></div>"
    end
  end

  private

  def class_active(number)
    number.zero? ? 'active' : ''
  end
end
