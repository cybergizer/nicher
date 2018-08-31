module SliderHelper
  def indicators(images)
    result = ''
    0.upto(images.count - 1) do |counter|
      result << "<li class='#{class_active(counter)}' data-slide-to='#{counter}' data-target='#myCarousel'></li>"
    end
    result
  end

  def slides(images)
    result = ''
    images.each_with_index do |image, index|
      result << "<div class='item #{class_active(index)}'><img src='#{image.page_size.url}'></div>"
    end
    result
  end

  private

  def class_active(number)
    number.zero? ? 'active' : ''
  end
end
