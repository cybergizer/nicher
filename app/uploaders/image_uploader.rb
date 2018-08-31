class ImageUploader < ApplicationUploader
  URL = 'image.png'.freeze

  def store_dir
    "items/images/#{model.id}"
  end

  version :page_size do
    process resize_to_fill: [600, 400]
  end

  version :list_size do
    process resize_to_fill: [200, 200]
  end
end
