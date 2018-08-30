class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "items/images/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path([version_name, 'image.png'].compact.join('_'))
  end

  version :page_size do
    process resize_to_fill: [300, 300]
  end

  version :list_size do
    process resize_to_fill: [200, 200]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
